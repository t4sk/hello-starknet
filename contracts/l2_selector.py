from starkware.starknet.compiler.compile import get_selector_from_name
 
FUNCTION_NAME = "receive_from_l1"
selector = get_selector_from_name(FUNCTION_NAME)
print(selector)
