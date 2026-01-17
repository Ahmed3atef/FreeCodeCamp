def hanoi_solver(n: int) -> str:

    rods = [list(range(n, 0, -1)), [], []]
    
    history = []
    
    def capture_state():
        state = f"{rods[0]} {rods[1]} {rods[2]}"
        history.append(state)
        
    def move(num_disks, source_idx, target_idx, aux_idx):
        if num_disks > 0:
            
            move(num_disks - 1, source_idx, aux_idx, target_idx)
            
            disk = rods[source_idx].pop()
            rods[target_idx].append(disk)
            capture_state()
            
            move(num_disks - 1, aux_idx, target_idx, source_idx)
    
    capture_state()
    move(n, 0, 2, 1)
    
    return "\n".join(history)

print(hanoi_solver(3))