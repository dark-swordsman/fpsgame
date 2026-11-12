class_name ItemController extends Resource

var items: Dictionary[int, Item]

enum AddStatus { SUCCESS, FAIL_UNSPECIFIED }
enum RemoveStatus { SUCCESS, NOT_FOUND }

# an item manager may be created on every new start, but
# it's actual data may be loaded separately, like
# from the disk

func add_item(item: Item) -> AddStatus:
	var result: bool = items.set(item.get_instance_id(), item)
	if result:
		return AddStatus.SUCCESS
	else:
		return AddStatus.FAIL_UNSPECIFIED
		
func remove_item(instance_id: int) -> RemoveStatus:
	var result: bool = items.erase(instance_id)
	if result:
		return RemoveStatus.SUCCESS
	else:
		return RemoveStatus.NOT_FOUND

func find_item_by_id(instance_id: int) -> Item:
	return items.find_key(instance_id)
