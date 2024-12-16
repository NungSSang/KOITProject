package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ItemDao;
import com.example.demo.dto.Item;

@Service
public class ItemService {

	ItemDao itemDao;

	public ItemService(ItemDao itemDao) {
		this.itemDao = itemDao;
	}

	public List<Item> getItemsByCharacterId(int characterId) {
		return itemDao.getItemsByCharacterId(characterId);
	}

	public void getItem() {
		itemDao.getItem();
	}

	public List<Item> itemDropByEnemyType(String enemyType) {
		return itemDao.itemDropByEnemyType(enemyType);
	}

	public void itemInsertToCharacter(int characterId, int itemId) {
		itemDao.itemInsertToCharacter(characterId, itemId);
	}

	public void itemUpdateToCharacter(int characterId, int itemId) {
		itemDao.itemUpdateToCharacter(characterId, itemId);
	}

	public Item getItemStorageByItemName(int characterId, int itemId) {
		return itemDao.getItemStorageByItemName(characterId, itemId);
	}

	public void goldInsertToCharacter(int characterId, int gold) {
		itemDao.goldInsertToCharacter(characterId, gold);
	}

	public void goldUpdateToCharacter(int characterId, int gold) {
		itemDao.goldUpdateToCharacter(characterId, gold);
	}

	public List<List<Item>> craftableItems(int characterId) {
		
		 // 내가 가진 아이템을 데이터베이스에서 가져오기
        List<Item> availableItems = itemDao.getItemsByCharacterId(characterId); // ID와 수량을 가진 아이템 리스트
        List<Item> creatableItems = itemDao.showCreateItem();    // 제작 가능한 아이템 리스트
        List<List<Item>> creatableItemsName = new ArrayList<>();

        try {
            for (Item item : creatableItems) {
                // 아이템 제작에 필요한 정보 파싱
                String[] neededItemIds = item.getNeedItem().split(",");
                String[] neededItemCounts = item.getNeedItemInt().split(",");
                boolean canCreate = true;

                // 제작 가능 여부를 확인
                for (int i = 0; i < neededItemIds.length; i++) {
                    int neededItemId = Integer.parseInt(neededItemIds[i]);
                    int neededItemCount = Integer.parseInt(neededItemCounts[i]);

                    // 내가 가진 아이템에서 해당 ID를 가진 아이템의 수량 확인
                    Optional<Item> matchingItem = availableItems.stream()
                        .filter(availableItem -> availableItem.getItemId() == neededItemId)
                        .findFirst();

                    // 아이템이 없거나 수량이 부족하면 제작 불가능
                    if (matchingItem.isEmpty() || matchingItem.get().getItemCount() < neededItemCount) {
                        canCreate = false;
                        break;
                    }
                }

                // 제작 가능한 경우에만 리스트에 추가
                if (canCreate) {
                    List<Item> beforeCreatableItemsName = new ArrayList<>();

                    for (int i = 0; i < neededItemIds.length; i++) {
                        int neededItemId = Integer.parseInt(neededItemIds[i]);
                        int neededItemCount = Integer.parseInt(neededItemCounts[i]);

                        // 제작 과정에 필요한 하위 아이템을 가져옴
                        List<Item> craftableItems = itemDao.craftableItems(characterId, neededItemId, neededItemCount);
                        beforeCreatableItemsName.addAll(craftableItems);
                    }

                    // 최종적으로 제작 가능한 아이템을 리스트에 추가
                    creatableItemsName.add(beforeCreatableItemsName);
                    System.out.println("제작 가능한 아이템: " + item.getItemName());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 최종 결과 출력
        System.out.println("최종 제작 가능한 아이템 리스트: " + creatableItemsName);

		
		
//		List<List<Item>> creatableItemsName = new ArrayList<>();
//		List<Item> creatableItems = itemDao.showCreateItem();
//		List<Integer> names = new ArrayList<>();
//		for(int j = 0; j < creatableItems.size(); j ++) {
//			names.add(itemDao.showCreateItem().get(j).getId()); 
//		}
//		try {
//			for (Item item : creatableItems) {
//				List<Item> beforeCreatableItemsName = new ArrayList<>();
//	            String[] neededItemIds = item.getNeedItem().split(",");
//	            String[] neededItemCounts = item.getNeedItemInt().split(",");
//	            	
//	            for (int i = 0; i < neededItemIds.length; i++) {
//	                int neededItemId = Integer.parseInt(neededItemIds[i]);
//	                int neededItemCount = Integer.parseInt(neededItemCounts[i]);
//	                beforeCreatableItemsName.addAll(itemDao.craftableItems(2, neededItemId, neededItemCount));
//	                System.out.println(itemDao.craftableItems(2, neededItemId, neededItemCount).size());
//	            }
//	            creatableItemsName.add(beforeCreatableItemsName);
//	            
//			}
//		} catch (Exception e) {
//			e.printStackTrace(); 
//		}
//		System.out.println(creatableItemsName);
		
//		for (List<Item> a : creatableItemsName) {
//			for (Item b : a ) {
//				if (b == null) {
//					creatableItemsName.remove(a);
//					break;
//				}
//			}
//		}
		
		return creatableItemsName;
	}

}
