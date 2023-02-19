from starkware.starknet.compiler.compile import get_selector_from_name
 
FUNCTION_NAME = "receive_l1_msg"
selector = get_selector_from_name(FUNCTION_NAME)
print(selector)
