From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Thu, 13 Aug 2009 20:34:48 +0200
Message-ID: <20090813183448.GA8125@elte.hu>
References: <20090812183934.777715527@de.ibm.com> <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56240 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZHMSfP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Aug 2009 14:35:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Now, there is one advantage to inlining that I really like - and 
> that I personally have missed from the days when we used to 
> always do it: profiling. Inlining the spinlocks tends to do 
> _wonders_ for showing exactly which spinlock ends up being the 
> contention cases for certain loads. [...]

We've got a new tool to determine that kind of information though: 
perf + call-graph profiling.

This is how it works and how it can be used. Say we want to profile 
'bw_tcp' from lmbench. The traditional way is to record a flat 
profile:

 aldebaran:~/l> perf record -f ./bw_pipe
 Pipe bandwidth: 4607.33 MB/sec
 [ perf record: Captured and wrote 2.503 MB perf.data (~109368 samples) ]

and then to view the flat profile:

 aldebaran:~/l> perf report
 # Samples: 109331
 #
 # Overhead  Command             Shared Object  Symbol
 # ........  .......  ........................  ......
 #
    39.61%  bw_pipe  [kernel]                  [k] copy_user_generic_string
    19.32%  bw_pipe  ./bw_pipe                 [.] enough_duration
     6.21%  bw_pipe  [kernel]                  [k] mutex_spin_on_owner
     3.54%  bw_pipe  ./bw_pipe                 [.] two_op
     3.54%  bw_pipe  ./bw_pipe                 [.] one_op
     2.79%  bw_pipe  [kernel]                  [k] get_page_from_freelist
     2.16%  bw_pipe  [kernel]                  [k] ia32_sysenter_target
     1.91%  bw_pipe  [kernel]                  [k] pipe_read
     1.83%  bw_pipe  [kernel]                  [k] pipe_write
     1.63%  bw_pipe  [kernel]                  [k] free_hot_cold_page
     1.21%  bw_pipe  [kernel]                  [k] put_page
     1.19%  bw_pipe  [kernel]                  [k] __alloc_pages_nodemask
     0.99%  bw_pipe  [kernel]                  [k] anon_pipe_buf_release
     0.74%  bw_pipe  [kernel]                  [k] get_pageblock_flags_group

Annoyingly enough, mutex_spin_on_owner() is in the profile but we 
have no idea what the parent function(s) are. (Plus there's no way 
we could reasonably inline mutex functions.) So we are stuck with 
guessing which of the many other functions above (or some other 
function which does not even get listed!) has that mutex spinning 
overhead.

But if you do the recording via call-graph traces:

 aldebaran:~/l> perf record -g -f ./bw_pipe
 Pipe bandwidth: 4432.75 MB/sec
 [ perf record: Captured and wrote 7.550 MB perf.data (~329886 samples) ]

(note the -g/--graph option) And then view the profile via perf 
report, we get:

 aldebaran:~/l> perf report -S _spin_lock

 # symbol: _spin_lock
 # Samples: 724
 #
 # Overhead  Command             Shared Object
 # ........  .......  ........................
 #
    98.34%  lat_tcp  [kernel]                
                |          
                |--31.74%-- ipt_do_table
                |          |          
                |          |--26.99%-- ipt_local_in_hook
                |          |          nf_iterate
                |          |          nf_hook_slow
                |          |          ip_local_deliver
                |          |          ip_rcv_finish
                |          |          ip_rcv
                |          |          netif_receive_skb
                |          |          process_backlog
                |          |          net_rx_action
                |          |          __do_softirq
                |          |          call_softirq
                |          |          do_softirq
                |          |          _local_bh_enable_ip
                |          |          local_bh_enable
                |          |          dev_queue_xmit
                |          |          ip_finish_output2
                |          |          ip_finish_output
                |          |          ip_output
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |          |--24.34%-- ipt_local_in_hook
                |          |          nf_iterate
                |          |          nf_hook_slow
                |          |          ip_local_deliver
                |          |          ip_rcv_finish
                |          |          ip_rcv
                |          |          netif_receive_skb
                |          |          process_backlog
                |          |          net_rx_action
                |          |          __do_softirq
                |          |          call_softirq
                |          |          do_softirq
                |          |          _local_bh_enable_ip
                |          |          local_bh_enable
                |          |          dev_queue_xmit
                |          |          ip_finish_output2
                |          |          ip_finish_output
                |          |          ip_output
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |          |--16.81%-- ipt_pre_routing_hook
                |          |          nf_iterate
                |          |          nf_hook_slow
                |          |          ip_rcv
                |          |          netif_receive_skb
                |          |          process_backlog
                |          |          net_rx_action
                |          |          __do_softirq
                |          |          call_softirq
                |          |          do_softirq
                |          |          _local_bh_enable_ip
                |          |          local_bh_enable
                |          |          dev_queue_xmit
                |          |          ip_finish_output2
                |          |          ip_finish_output
                |          |          ip_output
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |          |--11.95%-- ipt_post_routing_hook
                |          |          nf_iterate
                |          |          nf_hook_slow
                |          |          ip_output
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |          |--10.18%-- ipt_local_out_hook
                |          |          nf_iterate
                |          |          nf_hook_slow
                |          |          __ip_local_out
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |           --9.73%-- ipt_local_hook
                |                     nf_iterate
                |                     nf_hook_slow
                |                     __ip_local_out
                |                     ip_local_out
                |                     ip_queue_xmit
                |                     tcp_transmit_skb
                |                     tcp_write_xmit
                |                     __tcp_push_pending_frames
                |                     tcp_push
                |                     tcp_sendmsg
                |                     __sock_sendmsg
                |                     sock_aio_write
                |                     do_sync_write
                |                     vfs_write
                |                     sys_write
                |                     sysenter_dispatch
                |                     0xf7f50430
                |                     0x5
                |          
                |--31.46%-- __mod_timer
                |          mod_timer
                |          sk_reset_timer
                |          |          
                |          |--55.36%-- tcp_send_delayed_ack
                |          |          __tcp_ack_snd_check
                |          |          tcp_rcv_established
                |          |          tcp_v4_do_rcv
                |          |          tcp_prequeue_process
                |          |          tcp_recvmsg
                |          |          sock_common_recvmsg
                |          |          __sock_recvmsg
                |          |          sock_aio_read
                |          |          do_sync_read
                |          |          vfs_read
                |          |          sys_read
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |           --44.64%-- tcp_v4_rcv
                |                     ip_local_deliver_finish
                |                     ip_local_deliver
                |                     ip_rcv_finish
                |                     ip_rcv
                |                     netif_receive_skb
                |                     process_backlog
                |                     net_rx_action
                |                     __do_softirq
                |                     call_softirq
                |                     do_softirq
                |                     _local_bh_enable_ip
                |                     local_bh_enable
                |                     dev_queue_xmit
                |                     ip_finish_output2
                |                     ip_finish_output
                |                     ip_output
                |                     ip_local_out
                |                     ip_queue_xmit
                |                     tcp_transmit_skb
                |                     tcp_write_xmit
                |                     __tcp_push_pending_frames
                |                     tcp_push
                |                     tcp_sendmsg
                |                     __sock_sendmsg
                |                     sock_aio_write
                |                     do_sync_write
                |                     vfs_write
                |                     sys_write
                |                     sysenter_dispatch
                |                     0xf7f50430
                |                     0x5
                |          
                |--21.21%-- task_rq_lock
                |          try_to_wake_up
                |          default_wake_function
                |          |          
                |          |--99.34%-- autoremove_wake_function
                |          |          __wake_up_common
                |          |          __wake_up
                |          |          tcp_v4_rcv
                |          |          ip_local_deliver_finish
                |          |          ip_local_deliver
                |          |          ip_rcv_finish
                |          |          ip_rcv
                |          |          netif_receive_skb
                |          |          process_backlog
                |          |          net_rx_action
                |          |          __do_softirq
                |          |          call_softirq
                |          |          do_softirq
                |          |          _local_bh_enable_ip
                |          |          local_bh_enable
                |          |          dev_queue_xmit
                |          |          ip_finish_output2
                |          |          ip_finish_output
                |          |          ip_output
                |          |          ip_local_out
                |          |          ip_queue_xmit
                |          |          tcp_transmit_skb
                |          |          tcp_write_xmit
                |          |          __tcp_push_pending_frames
                |          |          tcp_push
                |          |          tcp_sendmsg
                |          |          __sock_sendmsg
                |          |          sock_aio_write
                |          |          do_sync_write
                |          |          vfs_write
                |          |          sys_write
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |           --0.66%-- pollwake
                |                     __wake_up_common
                |                     __wake_up
                |                     perf_counter_wakeup
                |                     perf_pending_counter
                |                     perf_counter_do_pending
                |                     smp_perf_pending_interrupt
                |                     perf_pending_interrupt
                |                     0xf7f50430
                |                     0x5
                |          
                |--5.06%-- tcp_v4_rcv
                |          ip_local_deliver_finish
                |          ip_local_deliver
                |          ip_rcv_finish
                |          ip_rcv
                |          netif_receive_skb
                |          process_backlog
                |          net_rx_action
                |          __do_softirq
                |          call_softirq
                |          do_softirq
                |          _local_bh_enable_ip
                |          local_bh_enable
                |          dev_queue_xmit
                |          ip_finish_output2
                |          ip_finish_output
                |          ip_output
                |          ip_local_out
                |          ip_queue_xmit
                |          tcp_transmit_skb
                |          tcp_write_xmit
                |          __tcp_push_pending_frames
                |          tcp_push
                |          tcp_sendmsg
                |          __sock_sendmsg
                |          sock_aio_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          sysenter_dispatch
                |          0xf7f50430
                |          0x5
                |          
                |--4.07%-- __perf_counter_sched_out
                |          perf_counter_task_sched_out
                |          schedule
                |          schedule_timeout
                |          sk_wait_data
                |          tcp_recvmsg
                |          sock_common_recvmsg
                |          __sock_recvmsg
                |          sock_aio_read
                |          do_sync_read
                |          vfs_read
                |          sys_read
                |          sysenter_dispatch
                |          0xf7f50430
                |          0x5
                |          
                |--1.40%-- ipt_local_hook
                |          nf_iterate
                |          nf_hook_slow
                |          __ip_local_out
                |          ip_local_out
                |          ip_queue_xmit
                |          tcp_transmit_skb
                |          tcp_write_xmit
                |          __tcp_push_pending_frames
                |          tcp_push
                |          tcp_sendmsg
                |          __sock_sendmsg
                |          sock_aio_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          sysenter_dispatch
                |          0xf7f50430
                |          0x5
                |          
                |--1.26%-- mod_timer
                |          sk_reset_timer
                |          |          
                |          |--66.67%-- tcp_send_delayed_ack
                |          |          __tcp_ack_snd_check
                |          |          tcp_rcv_established
                |          |          tcp_v4_do_rcv
                |          |          tcp_prequeue_process
                |          |          tcp_recvmsg
                |          |          sock_common_recvmsg
                |          |          __sock_recvmsg
                |          |          sock_aio_read
                |          |          do_sync_read
                |          |          vfs_read
                |          |          sys_read
                |          |          sysenter_dispatch
                |          |          0xf7f50430
                |          |          0x5
                |          |          
                |           --33.33%-- tcp_v4_rcv
                |                     ip_local_deliver_finish
                |                     ip_local_deliver
                |                     ip_rcv_finish
                |                     ip_rcv
                |                     netif_receive_skb
                |                     process_backlog
                |                     net_rx_action
                |                     __do_softirq
                |                     call_softirq
                |                     do_softirq
                |                     _local_bh_enable_ip
                |                     local_bh_enable
                |                     dev_queue_xmit
                |                     ip_finish_output2
                |                     ip_finish_output
                |                     ip_output
                |                     ip_local_out
                |                     ip_queue_xmit
                |                     tcp_transmit_skb
                |                     tcp_write_xmit
                |                     __tcp_push_pending_frames
                |                     tcp_push
                |                     tcp_sendmsg
                |                     __sock_sendmsg
                |                     sock_aio_write
                |                     do_sync_write
                |                     vfs_write
                |                     sys_write
                |                     sysenter_dispatch
                |                     0xf7f50430
                |                     0x5
                |          
                |--0.70%-- ipt_local_in_hook
                |          nf_iterate
                |          nf_hook_slow
                |          ip_local_deliver
                |          ip_rcv_finish
                |          ip_rcv
                |          netif_receive_skb
                |          process_backlog
                |          net_rx_action
                |          __do_softirq
                |          call_softirq
                |          do_softirq
                |          _local_bh_enable_ip
                |          local_bh_enable
                |          dev_queue_xmit
                |          ip_finish_output2
                |          ip_finish_output
                |          ip_output
                |          ip_local_out
                |          ip_queue_xmit
                |          tcp_transmit_skb
                |          tcp_write_xmit
                |          __tcp_push_pending_frames
                |          tcp_push
                |          tcp_sendmsg
                |          __sock_sendmsg
                |          sock_aio_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          sysenter_dispatch
                |          0xf7f50430
                |          0x5
                |          
                |--0.56%-- perf_counter_task_sched_out
                |          schedule
                |          schedule_timeout
                |          sk_wait_data
                |          tcp_recvmsg
                |          sock_common_recvmsg
                |          __sock_recvmsg
                |          sock_aio_read
                |          do_sync_read
                |          vfs_read
                |          sys_read
                |          sysenter_dispatch
                |          0xf7f50430
                |          0x5
                 --2.53%-- [...]

     1.66%     perf  [kernel]                
                |          
                |--25.00%-- journal_stop
                |          __ext3_journal_stop
                |          ext3_writeback_write_end
                |          generic_perform_write
                |          generic_file_buffered_write
                |          __generic_file_aio_write_nolock
                |          generic_file_aio_write
                |          ext3_file_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          system_call_fastpath
                |          __write_nocancel
                |          
                |--16.67%-- __perf_counter_sched_out
                |          perf_counter_task_sched_out
                |          schedule
                |          schedule_hrtimeout_range
                |          poll_schedule_timeout
                |          do_poll
                |          do_sys_poll
                |          sys_poll
                |          system_call_fastpath
                |          __GI___poll
                |          
                |--8.33%-- dup_mmap
                |          dup_mm
                |          copy_process
                |          do_fork
                |          sys_clone
                |          stub_clone
                |          fork
                |          __cmd_record
                |          
                |--8.33%-- hrtimer_interrupt
                |          smp_apic_timer_interrupt
                |          apic_timer_interrupt
                |          __write_nocancel
                |          
                |--8.33%-- journal_start
                |          ext3_journal_start_sb
                |          ext3_write_begin
                |          generic_perform_write
                |          generic_file_buffered_write
                |          __generic_file_aio_write_nolock
                |          generic_file_aio_write
                |          ext3_file_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          system_call_fastpath
                |          __write_nocancel
                |          
                |--8.33%-- create_empty_buffers
                |          __block_prepare_write
                |          block_write_begin
                |          ext3_write_begin
                |          generic_perform_write
                |          generic_file_buffered_write
                |          __generic_file_aio_write_nolock
                |          generic_file_aio_write
                |          ext3_file_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          system_call_fastpath
                |          __write_nocancel
                |          
                |--8.33%-- perf_counter_task_sched_out
                |          schedule
                |          schedule_hrtimeout_range
                |          poll_schedule_timeout
                |          do_poll
                |          do_sys_poll
                |          sys_poll
                |          system_call_fastpath
                |          __GI___poll
                |          
                |--8.33%-- ext3_alloc_branch
                |          ext3_get_blocks_handle
                |          ext3_get_block
                |          __block_prepare_write
                |          block_write_begin
                |          ext3_write_begin
                |          generic_perform_write
                |          generic_file_buffered_write
                |          __generic_file_aio_write_nolock
                |          generic_file_aio_write
                |          ext3_file_write
                |          do_sync_write
                |          vfs_write
                |          sys_write
                |          system_call_fastpath
                |          __write_nocancel
                |          
                 --8.33%-- start_this_handle
                           journal_start
                           ext3_journal_start_sb
                           ext3_write_begin
                           generic_perform_write
                           generic_file_buffered_write
                           __generic_file_aio_write_nolock
                           generic_file_aio_write
                           ext3_file_write
                           do_sync_write
                           vfs_write
                           sys_write
                           system_call_fastpath
                           __write_nocancel

the graph above (which is the sub-graph of the full graph, limited 
via the -S/--symbols option to all callchains that intersect with 
the _spin_lock symbol) details all the various code-paths that make 
use of _spin_lock(), and the weights (and relative weights) of 
those codepaths.

Note that this works for just about any locking primitive, and note 
how it's recursive. If we inlined spin_lock we'd only know this 
__mod_timer overhead:

                |--31.46%-- __mod_timer

but we wouldnt know the second level (which is interesting too):

                |          |--55.36%-- tcp_send_delayed_ack
                |           --44.64%-- tcp_v4_rcv

All in one, i think we should detach the issue of instrumentation 
and profiling from the issue of whether to inline or not. We should 
inline where it makes things faster. Our profiling tools are able 
to deal with it, independently of whether we inline or not.

	Ingo
