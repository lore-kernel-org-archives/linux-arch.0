From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 14:34:39 +0200
Message-ID: <20090814123439.GB4959@osiris.boeblingen.de.ibm.com>
References: <20090812183934.777715527@de.ibm.com>
 <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47995 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbZHNMey (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2009 08:34:54 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.14.3/8.13.8) with ESMTP id n7ECYfFL293418
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 12:34:41 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7ECYfZv905216
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 14:34:41 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7ECYeHm006602
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 14:34:41 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

On Thu, Aug 13, 2009 at 11:11:22AM -0700, Linus Torvalds wrote:
> On Wed, 12 Aug 2009, Heiko Carstens wrote:
> > If one considers that server kernels are usually compiled with
> > !CONFIG_PREEMPT a simple spin_lock is just a compare and swap loop.
> > The extra overhead for a function call is significant.
> > With inlined spinlocks overall cpu usage gets reduced by 1%-5% on s390.
> > These numbers were taken with some network benchmarks. However I expect
> > any workload that calls frequently into the kernel and which grabs a few
> > locks to perform better.
> 
> Have you tried to determine which kinds of spinlocks you care most about? 
> With networking, I guess the softirq-safe ones (and perhaps the irq ones) 
> are pretty common, but maybe even there it's really just a couple of 
> cases.

It's all spinlock* variants that are frequently called (see also below).
 
> [...]
> So there are advantages outside of the "size vs speed" kind of things, but 
> at the same time I do suspect that the disadvantages mean that we really 
> should make this be something where an architecture can specify things at 
> a finer granularity. Perhaps by using per-symbol defines (ie have the 
> <asm/spinlock.h> file do things like
> 
> 	#define __spin_lock_is_small
> 	#define __spin_unlock_is_small
> 
> kind of things for the particular sequences that are worth inlining.

Ok, that makes sense. I will post updated patches.

FWIW:
All of this started when we compared a 2.6.27 based distro kernel
to a 2.6.16 based one. It turned out that 2.6.27 burns a lot more cpu
cycles than 2.6.16 does for the same workloads.

As an example: we took a simple one connection ping pong network load.
(client sends packet to server and waits until packet from server
 returns and game starts again). It uses more cpu cycles on 2.6.27.

Using ftrace we figured out that on 2.6.27 it takes more than 500 function
calls on the client for a single roundtrip while on 2.6.16 it took only
~230 calls.
Changing s390 from its own NOHZ code to the generic version did cost
quite a few cycles. The idle entry and exit paths are much more expensive
now. That's why you've seen Martin posting NOHZ/timer related patches lately.

But also quite a few functions that were inlined in 2.6.16 are out-of-line
in 2.6.27. Reverting those changes did improve performance as well.

Since out of the ~500 function calls 60 are spin_[un]lock* calls it seemed
worthwile inlining them. Which also improved things again.

Here are the function traces for 2.6.27 and 2.6.16:
(the timestamp output has been modified)

For 2.6.27:

# tracer: ftrace
#
#           TASK-PID   CPU#    TIMESTAMP  FUNCTION
#              | |      |          |         |
            perl-2581  [00] 28991519113889978 [+  125]: SyS_write <-sysc_noemu
            perl-2581  [00] 28991519113890103 [+  156]: fget_light <-SyS_write
            perl-2581  [00] 28991519113890259 [+  125]: vfs_write <-SyS_write
            perl-2581  [00] 28991519113890384 [+  156]: rw_verify_area <-vfs_write
            perl-2581  [00] 28991519113890540 [+  125]: security_file_permission <-rw_verify_area
            perl-2581  [00] 28991519113890665 [+   93]: apparmor_file_permission <-security_file_permission
            perl-2581  [00] 28991519113890759 [+  156]: aa_file_permission <-apparmor_file_permission
            perl-2581  [00] 28991519113890915 [+  125]: do_sync_write <-vfs_write
            perl-2581  [00] 28991519113891040 [+  125]: sock_aio_write <-do_sync_write
            perl-2581  [00] 28991519113891165 [+  125]: security_socket_sendmsg <-sock_aio_write
            perl-2581  [00] 28991519113891290 [+  125]: apparmor_socket_sendmsg <-security_socket_sendmsg
            perl-2581  [00] 28991519113891415 [+  125]: aa_revalidate_sk <-apparmor_socket_sendmsg
            perl-2581  [00] 28991519113891540 [+  125]: tcp_sendmsg <-sock_aio_write
            perl-2581  [00] 28991519113891665 [+  125]: lock_sock_nested <-tcp_sendmsg
            perl-2581  [00] 28991519113891790 [+  125]: _spin_lock_bh <-lock_sock_nested
            perl-2581  [00] 28991519113891915 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519113892040 [+  187]: local_bh_enable <-lock_sock_nested
            perl-2581  [00] 28991519113892228 [+  125]: tcp_current_mss <-tcp_sendmsg
            perl-2581  [00] 28991519113892353 [+  156]: tcp_established_options <-tcp_current_mss
            perl-2581  [00] 28991519113892509 [+  125]: sk_stream_alloc_skb <-tcp_sendmsg
            perl-2581  [00] 28991519113892634 [+  125]: __alloc_skb <-sk_stream_alloc_skb
            perl-2581  [00] 28991519113892759 [+  156]: kmem_cache_alloc <-__alloc_skb
            perl-2581  [00] 28991519113892915 [+  281]: __kmalloc <-__alloc_skb
            perl-2581  [00] 28991519113893196 [+  125]: skb_put <-tcp_sendmsg
            perl-2581  [00] 28991519113893321 [+  125]: copy_from_user_mvcos_check <-tcp_sendmsg
            perl-2581  [00] 28991519113893446 [+  156]: copy_from_user_std <-copy_from_user_mvcos_check
            perl-2581  [00] 28991519113893603 [+  125]: __tcp_push_pending_frames <-tcp_sendmsg
            perl-2581  [00] 28991519113893728 [+  125]: tcp_init_tso_segs <-__tcp_push_pending_frames
            perl-2581  [00] 28991519113893853 [+  125]: tcp_set_skb_tso_segs <-tcp_init_tso_segs
            perl-2581  [00] 28991519113893978 [+  156]: tcp_transmit_skb <-__tcp_push_pending_frames
            perl-2581  [00] 28991519113894134 [+   93]: skb_clone <-tcp_transmit_skb
            perl-2581  [00] 28991519113894228 [+  125]: __skb_clone <-skb_clone
            perl-2581  [00] 28991519113894353 [+  156]: __copy_skb_header <-__skb_clone
            perl-2581  [00] 28991519113894509 [+  125]: tcp_established_options <-tcp_transmit_skb
            perl-2581  [00] 28991519113894634 [+  125]: skb_push <-tcp_transmit_skb
            perl-2581  [00] 28991519113894759 [+  156]: __tcp_select_window <-tcp_transmit_skb
            perl-2581  [00] 28991519113894915 [+  125]: tcp_options_write <-tcp_transmit_skb
            perl-2581  [00] 28991519113895040 [+  156]: tcp_v4_send_check <-tcp_transmit_skb
            perl-2581  [00] 28991519113895196 [+  125]: ip_queue_xmit <-tcp_transmit_skb
            perl-2581  [00] 28991519113895321 [+  156]: __sk_dst_check <-ip_queue_xmit
            perl-2581  [00] 28991519113895478 [+  125]: skb_push <-ip_queue_xmit
            perl-2581  [00] 28991519113895603 [+   93]: ip_local_out <-ip_queue_xmit
            perl-2581  [00] 28991519113895696 [+  156]: __ip_local_out <-ip_local_out
            perl-2581  [00] 28991519113895853 [+  125]: ip_output <-ip_local_out
            perl-2581  [00] 28991519113895978 [+  156]: ip_finish_output <-ip_output
            perl-2581  [00] 28991519113896134 [+  125]: skb_push <-ip_finish_output
            perl-2581  [00] 28991519113896259 [+  125]: dev_queue_xmit <-ip_finish_output
            perl-2581  [00] 28991519113896384 [+  125]: local_bh_disable <-dev_queue_xmit
            perl-2581  [00] 28991519113896509 [+  187]: _spin_lock <-dev_queue_xmit
            perl-2581  [00] 28991519113896696 [+  125]: pfifo_fast_enqueue <-dev_queue_xmit
            perl-2581  [00] 28991519113896821 [+  125]: __qdisc_run <-dev_queue_xmit
            perl-2581  [00] 28991519113896946 [+  156]: pfifo_fast_dequeue <-__qdisc_run
            perl-2581  [00] 28991519113897103 [+  125]: _spin_lock <-__qdisc_run
            perl-2581  [00] 28991519113897228 [+  187]: dev_hard_start_xmit <-__qdisc_run
            perl-2581  [00] 28991519113897415 [+  156]: qeth_l3_hard_start_xmit <-dev_hard_start_xmit
            perl-2581  [00] 28991519113897571 [+  125]: qeth_get_cast_type <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113897696 [+  156]: qeth_get_priority_queue <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113897853 [+  125]: skb_realloc_headroom <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113897978 [+  125]: pskb_copy <-skb_realloc_headroom
            perl-2581  [00] 28991519113898103 [+   93]: __alloc_skb <-pskb_copy
            perl-2581  [00] 28991519113898196 [+  187]: kmem_cache_alloc <-__alloc_skb
            perl-2581  [00] 28991519113898384 [+  218]: __kmalloc <-__alloc_skb
            perl-2581  [00] 28991519113898603 [+  156]: skb_put <-pskb_copy
            perl-2581  [00] 28991519113898759 [+   93]: copy_skb_header <-pskb_copy
            perl-2581  [00] 28991519113898853 [+  218]: __copy_skb_header <-copy_skb_header
            perl-2581  [00] 28991519113899071 [+  125]: skb_pull <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113899196 [+  125]: skb_push <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113899321 [+  156]: qeth_l3_fill_header <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113899478 [+  125]: qeth_get_elements_no <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113899603 [+  156]: qeth_do_send_packet <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113899759 [+  125]: skb_queue_tail <-qeth_do_send_packet
            perl-2581  [00] 28991519113899884 [+  125]: _spin_lock_irqsave <-skb_queue_tail
            perl-2581  [00] 28991519113900009 [+  156]: _spin_unlock_irqrestore <-skb_queue_tail
            perl-2581  [00] 28991519113900165 [+  187]: qeth_flush_buffers <-qeth_do_send_packet
            perl-2581  [00] 28991519113900353 [+  156]: do_QDIO <-qeth_flush_buffers
            perl-2581  [00] 28991519113900509 [+  156]: qdio_perf_stat_inc <-do_QDIO
            perl-2581  [00] 28991519113900665 [+  125]: qdio_kick_outbound_q <-do_QDIO
            perl-2581  [00] 28991519113900790 [+  812]: qdio_perf_stat_inc <-qdio_kick_outbound_q
            perl-2581  [00] 28991519113901603 [+  218]: __tasklet_schedule <-do_QDIO
            perl-2581  [00] 28991519113901821 [+  156]: dev_kfree_skb_any <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113901978 [+  125]: kfree_skb <-dev_kfree_skb_any
            perl-2581  [00] 28991519113902103 [+   93]: __kfree_skb <-kfree_skb
            perl-2581  [00] 28991519113902196 [+  125]: skb_release_all <-__kfree_skb
            perl-2581  [00] 28991519113902321 [+  156]: dst_release <-skb_release_all
            perl-2581  [00] 28991519113902478 [+   93]: sock_wfree <-skb_release_all
            perl-2581  [00] 28991519113902571 [+  187]: skb_release_data <-skb_release_all
            perl-2581  [00] 28991519113902759 [+  125]: __netif_schedule <-qeth_l3_hard_start_xmit
            perl-2581  [00] 28991519113902884 [+  156]: raise_softirq_irqoff <-__netif_schedule
            perl-2581  [00] 28991519113903040 [+  125]: _spin_lock <-__qdisc_run
            perl-2581  [00] 28991519113903165 [+  187]: local_bh_enable <-dev_queue_xmit
            perl-2581  [00] 28991519113903353 [+  156]: do_softirq <-local_bh_enable
            perl-2581  [00] 28991519113903509 [+   93]: __do_softirq <-do_softirq
            perl-2581  [00] 28991519113903603 [+   93]: account_system_vtime <-__do_softirq
            perl-2581  [00] 28991519113903696 [+  125]: account_system_time <-account_system_vtime
            perl-2581  [00] 28991519113903821 [+   93]: acct_update_integrals <-account_system_time
            perl-2581  [00] 28991519113903915 [+  187]: jiffies_to_timeval <-acct_update_integrals
            perl-2581  [00] 28991519113904103 [+  156]: net_tx_action <-__do_softirq
            perl-2581  [00] 28991519113904259 [+  125]: _spin_trylock <-net_tx_action
            perl-2581  [00] 28991519113904384 [+  125]: __qdisc_run <-net_tx_action
            perl-2581  [00] 28991519113904509 [+  156]: pfifo_fast_dequeue <-__qdisc_run
            perl-2581  [00] 28991519113904665 [+  187]: tasklet_action <-__do_softirq
            perl-2581  [00] 28991519113904853 [+   93]: qdio_outbound_processing <-tasklet_action
            perl-2581  [00] 28991519113904946 [+  187]: qdio_perf_stat_inc <-qdio_outbound_processing
            perl-2581  [00] 28991519113905134 [+  156]: mod_timer <-qdio_outbound_processing
            perl-2581  [00] 28991519113905290 [+  125]: __timer_stats_timer_set_start_info <-mod_timer
            perl-2581  [00] 28991519113905415 [+  125]: __mod_timer <-mod_timer
            perl-2581  [00] 28991519113905540 [+  125]: __timer_stats_timer_set_start_info <-__mod_timer
            perl-2581  [00] 28991519113905665 [+   93]: lock_timer_base <-__mod_timer
            perl-2581  [00] 28991519113905759 [+  156]: _spin_lock_irqsave <-lock_timer_base
            perl-2581  [00] 28991519113905915 [+  125]: internal_add_timer <-__mod_timer
            perl-2581  [00] 28991519113906040 [+  125]: _spin_unlock_irqrestore <-__mod_timer
            perl-2581  [00] 28991519113906165 [+  156]: qdio_perf_stat_inc <-qdio_outbound_processing
            perl-2581  [00] 28991519113906321 [+  125]: account_system_vtime <-__do_softirq
            perl-2581  [00] 28991519113906446 [+   62]: account_system_time <-account_system_vtime
            perl-2581  [00] 28991519113906509 [+  125]: acct_update_integrals <-account_system_time
            perl-2581  [00] 28991519113906634 [+  125]: jiffies_to_timeval <-acct_update_integrals
            perl-2581  [00] 28991519113906759 [+  156]: _local_bh_enable <-__do_softirq
            perl-2581  [00] 28991519113906915 [+  125]: tcp_event_new_data_sent <-__tcp_push_pending_frames
            perl-2581  [00] 28991519113907040 [+  125]: sk_reset_timer <-tcp_event_new_data_sent
            perl-2581  [00] 28991519113907165 [+   93]: mod_timer <-sk_reset_timer
            perl-2581  [00] 28991519113907259 [+  187]: __timer_stats_timer_set_start_info <-mod_timer
            perl-2581  [00] 28991519113907446 [+  156]: release_sock <-tcp_sendmsg
            perl-2581  [00] 28991519113907603 [+  125]: _spin_lock_bh <-release_sock
            perl-2581  [00] 28991519113907728 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519113907853 [+  125]: _spin_unlock_bh <-release_sock
            perl-2581  [00] 28991519113907978 [+  187]: local_bh_enable_ip <-_spin_unlock_bh
            perl-2581  [00] 28991519113908165 [+   93]: dnotify_parent <-vfs_write
            perl-2581  [00] 28991519113908259 [+  156]: _spin_lock <-dnotify_parent
            perl-2581  [00] 28991519113908415 [+  156]: inotify_dentry_parent_queue_event <-vfs_write
            perl-2581  [00] 28991519113908571 [+  875]: inotify_inode_queue_event <-vfs_write
            perl-2581  [00] 28991519113909446 [+   93]: SyS_read <-sysc_noemu
            perl-2581  [00] 28991519113909540 [+  156]: fget_light <-SyS_read
            perl-2581  [00] 28991519113909696 [+  125]: vfs_read <-SyS_read
            perl-2581  [00] 28991519113909821 [+  125]: rw_verify_area <-vfs_read
            perl-2581  [00] 28991519113909946 [+  125]: security_file_permission <-rw_verify_area
            perl-2581  [00] 28991519113910071 [+  125]: apparmor_file_permission <-security_file_permission
            perl-2581  [00] 28991519113910196 [+  125]: aa_file_permission <-apparmor_file_permission
            perl-2581  [00] 28991519113910321 [+  156]: do_sync_read <-vfs_read
            perl-2581  [00] 28991519113910478 [+  125]: sock_aio_read <-do_sync_read
            perl-2581  [00] 28991519113910603 [+  125]: security_socket_recvmsg <-sock_aio_read
            perl-2581  [00] 28991519113910728 [+   93]: apparmor_socket_recvmsg <-security_socket_recvmsg
            perl-2581  [00] 28991519113910821 [+  156]: aa_revalidate_sk <-apparmor_socket_recvmsg
            perl-2581  [00] 28991519113910978 [+  125]: sock_common_recvmsg <-sock_aio_read
            perl-2581  [00] 28991519113911103 [+  125]: tcp_recvmsg <-sock_common_recvmsg
            perl-2581  [00] 28991519113911228 [+  125]: lock_sock_nested <-tcp_recvmsg
            perl-2581  [00] 28991519113911353 [+  125]: _spin_lock_bh <-lock_sock_nested
            perl-2581  [00] 28991519113911478 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519113911603 [+  250]: local_bh_enable <-lock_sock_nested
            perl-2581  [00] 28991519113911853 [+  125]: tcp_cleanup_rbuf <-tcp_recvmsg
            perl-2581  [00] 28991519113911978 [+  125]: sk_wait_data <-tcp_recvmsg
            perl-2581  [00] 28991519113912103 [+  125]: prepare_to_wait <-sk_wait_data
            perl-2581  [00] 28991519113912228 [+  125]: _spin_lock_irqsave <-prepare_to_wait
            perl-2581  [00] 28991519113912353 [+  125]: _spin_unlock_irqrestore <-prepare_to_wait
            perl-2581  [00] 28991519113912478 [+  125]: release_sock <-sk_wait_data
            perl-2581  [00] 28991519113912603 [+  125]: _spin_lock_bh <-release_sock
            perl-2581  [00] 28991519113912728 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519113912853 [+  125]: _spin_unlock_bh <-release_sock
            perl-2581  [00] 28991519113912978 [+  187]: local_bh_enable_ip <-_spin_unlock_bh
            perl-2581  [00] 28991519113913165 [+  125]: schedule_timeout <-sk_wait_data
            perl-2581  [00] 28991519113913290 [+  125]: schedule <-schedule_timeout
            perl-2581  [00] 28991519113913415 [+  125]: _spin_lock <-schedule
            perl-2581  [00] 28991519113913540 [+   93]: sched_clock_cpu <-schedule
            perl-2581  [00] 28991519113913634 [+  125]: sched_clock <-sched_clock_cpu
            perl-2581  [00] 28991519113913759 [+   93]: deactivate_task <-schedule
            perl-2581  [00] 28991519113913853 [+  125]: dequeue_task <-deactivate_task
            perl-2581  [00] 28991519113913978 [+   93]: dequeue_task_fair <-dequeue_task
            perl-2581  [00] 28991519113914071 [+   93]: dequeue_entity <-dequeue_task_fair
            perl-2581  [00] 28991519113914165 [+  156]: update_curr <-dequeue_entity
            perl-2581  [00] 28991519113914321 [+   93]: hrtick_start_fair <-dequeue_task_fair
            perl-2581  [00] 28991519113914415 [+  125]: put_prev_task_fair <-schedule
            perl-2581  [00] 28991519113914540 [+  125]: pick_next_task_fair <-schedule
            perl-2581  [00] 28991519113914665 [+   93]: pick_next_task_rt <-schedule
            perl-2581  [00] 28991519113914759 [+   93]: pick_next_task_fair <-schedule
            perl-2581  [00] 28991519113914853 [+  125]: pick_next_task_idle <-schedule
            perl-2581  [00] 28991519113914978 [+  218]: _spin_trylock <-tracing_record_cmdline
          <idle>-0     [00] 28991519113915196 [+  125]: finish_task_switch <-schedule
          <idle>-0     [00] 28991519113915321 [+   62]: account_vtime <-finish_task_switch
          <idle>-0     [00] 28991519113915384 [+   93]: account_user_time <-account_vtime
          <idle>-0     [00] 28991519113915478 [+   93]: acct_update_integrals <-account_user_time
          <idle>-0     [00] 28991519113915571 [+  125]: jiffies_to_timeval <-acct_update_integrals
          <idle>-0     [00] 28991519113915696 [+   93]: account_system_time <-account_vtime
          <idle>-0     [00] 28991519113915790 [+   93]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28991519113915884 [+  187]: jiffies_to_timeval <-acct_update_integrals
          <idle>-0     [00] 28991519113916071 [+  125]: tick_nohz_stop_sched_tick <-cpu_idle
          <idle>-0     [00] 28991519113916196 [+   93]: ktime_get <-tick_nohz_stop_sched_tick
          <idle>-0     [00] 28991519113916290 [+   93]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519113916384 [+   93]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519113916478 [+  125]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519113916603 [+  156]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519113916759 [+   93]: get_next_timer_interrupt <-tick_nohz_stop_sched_tick
          <idle>-0     [00] 28991519113916853 [+  125]: _spin_lock <-get_next_timer_interrupt
          <idle>-0     [00] 28991519113916978 [+   93]: hrtimer_get_next_event <-get_next_timer_interrupt
          <idle>-0     [00] 28991519113917071 [+  125]: _spin_lock_irqsave <-hrtimer_get_next_event
          <idle>-0     [00] 28991519113917196 [+   93]: _spin_unlock_irqrestore <-hrtimer_get_next_event
          <idle>-0     [00] 28991519113917290 [+   93]: rcu_needs_cpu <-tick_nohz_stop_sched_tick
          <idle>-0     [00] 28991519113917384 [+  156]: rcu_pending <-rcu_needs_cpu
          <idle>-0     [00] 28991519113917540 [+   93]: select_nohz_load_balancer <-tick_nohz_stop_sched_tick
          <idle>-0     [00] 28991519113917634 [+   93]: hweight64 <-select_nohz_load_balancer
          <idle>-0     [00] 28991519113917728 [+  156]: hweight64 <-select_nohz_load_balancer
          <idle>-0     [00] 28991519113917884 [+   62]: hrtimer_start <-tick_nohz_stop_sched_tick
          <idle>-0     [00] 28991519113917946 [+   93]: lock_hrtimer_base <-hrtimer_start
          <idle>-0     [00] 28991519113918040 [+  125]: _spin_lock_irqsave <-lock_hrtimer_base
          <idle>-0     [00] 28991519113918165 [+   93]: __remove_hrtimer <-hrtimer_start
          <idle>-0     [00] 28991519113918259 [+  125]: rb_next <-__remove_hrtimer
          <idle>-0     [00] 28991519113918384 [+  125]: hrtimer_force_reprogram <-__remove_hrtimer
          <idle>-0     [00] 28991519113918509 [+   93]: tick_program_event <-hrtimer_force_reprogram
          <idle>-0     [00] 28991519113918603 [+   93]: tick_dev_program_event <-tick_program_event
          <idle>-0     [00] 28991519113918696 [+   93]: ktime_get <-tick_dev_program_event
          <idle>-0     [00] 28991519113918790 [+   93]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519113918884 [+   62]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519113918946 [+  125]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519113919071 [+  125]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519113919196 [+   93]: clockevents_program_event <-tick_dev_program_event
          <idle>-0     [00] 28991519113919290 [+   93]: s390_next_event <-clockevents_program_event
          <idle>-0     [00] 28991519113919384 [+  156]: rb_erase <-__remove_hrtimer
          <idle>-0     [00] 28991519113919540 [+   93]: __timer_stats_hrtimer_set_start_info <-hrtimer_start
          <idle>-0     [00] 28991519113919634 [+   93]: enqueue_hrtimer <-hrtimer_start
          <idle>-0     [00] 28991519113919728 [+  125]: hrtimer_reprogram <-enqueue_hrtimer
          <idle>-0     [00] 28991519113919853 [+   62]: tick_program_event <-hrtimer_reprogram
          <idle>-0     [00] 28991519113919915 [+   93]: tick_dev_program_event <-tick_program_event
          <idle>-0     [00] 28991519113920009 [+   93]: ktime_get <-tick_dev_program_event
          <idle>-0     [00] 28991519113920103 [+   93]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519113920196 [+   62]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519113920259 [+  125]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519113920384 [+  125]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519113920509 [+   62]: clockevents_program_event <-tick_dev_program_event
          <idle>-0     [00] 28991519113920571 [+  125]: s390_next_event <-clockevents_program_event
          <idle>-0     [00] 28991519113920696 [+  125]: rb_insert_color <-enqueue_hrtimer
          <idle>-0     [00] 28991519113920821 [+  156]: _spin_unlock_irqrestore <-hrtimer_start
          <idle>-0     [00] 28991519113920978 [+  125]: _spin_lock <-cpu_idle
          <idle>-0     [00] 28991519113921103 [+229750]: vtime_stop_cpu_timer <-cpu_idle
          <idle>-0     [00] 28991519114150853 [+   93]: do_IRQ <-io_return
          <idle>-0     [00] 28991519114150946 [+   62]: irq_enter <-do_IRQ
          <idle>-0     [00] 28991519114151009 [+  125]: idle_cpu <-irq_enter
          <idle>-0     [00] 28991519114151134 [+   93]: tick_nohz_stop_idle <-irq_enter
          <idle>-0     [00] 28991519114151228 [+   62]: ktime_get <-tick_nohz_stop_idle
          <idle>-0     [00] 28991519114151290 [+  125]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519114151415 [+   62]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519114151478 [+   93]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519114151571 [+  125]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519114151696 [+   93]: account_system_vtime <-irq_enter
          <idle>-0     [00] 28991519114151790 [+   93]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28991519114151884 [+  125]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28991519114152009 [+   93]: idle_cpu <-irq_enter
          <idle>-0     [00] 28991519114152103 [+   62]: tick_nohz_update_jiffies <-irq_enter
          <idle>-0     [00] 28991519114152165 [+   93]: ktime_get <-tick_nohz_update_jiffies
          <idle>-0     [00] 28991519114152259 [+   93]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519114152353 [+   62]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519114152415 [+   93]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519114152509 [+  125]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519114152634 [+  125]: tick_do_update_jiffies64 <-tick_nohz_update_jiffies
          <idle>-0     [00] 28991519114152759 [+   62]: s390_idle_leave <-do_IRQ
          <idle>-0     [00] 28991519114152821 [+  125]: vtime_start_cpu_timer <-s390_idle_leave
          <idle>-0     [00] 28991519114152946 [+   93]: _spin_lock <-s390_idle_leave
          <idle>-0     [00] 28991519114153040 [+  250]: do_adapter_IO <-do_IRQ
          <idle>-0     [00] 28991519114153290 [+   93]: tiqdio_thinint_handler <-do_adapter_IO
          <idle>-0     [00] 28991519114153384 [+  156]: qdio_perf_stat_inc <-tiqdio_thinint_handler
          <idle>-0     [00] 28991519114153540 [+  250]: __tasklet_hi_schedule <-tiqdio_thinint_handler
          <idle>-0     [00] 28991519114153790 [+   93]: irq_exit <-do_IRQ
          <idle>-0     [00] 28991519114153884 [+   93]: account_system_vtime <-irq_exit
          <idle>-0     [00] 28991519114153978 [+   93]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28991519114154071 [+   93]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28991519114154165 [+   93]: do_softirq <-irq_exit
          <idle>-0     [00] 28991519114154259 [+   93]: __do_softirq <-do_softirq
          <idle>-0     [00] 28991519114154353 [+   62]: account_system_vtime <-__do_softirq
          <idle>-0     [00] 28991519114154415 [+  125]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28991519114154540 [+   93]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28991519114154634 [+   93]: tasklet_hi_action <-__do_softirq
          <idle>-0     [00] 28991519114154728 [+   93]: tiqdio_tasklet_fn <-tasklet_hi_action
          <idle>-0     [00] 28991519114154821 [+  218]: qdio_perf_stat_inc <-tiqdio_tasklet_fn
          <idle>-0     [00] 28991519114155040 [+  218]: __tasklet_schedule <-tiqdio_tasklet_fn
          <idle>-0     [00] 28991519114155259 [+  125]: tasklet_action <-__do_softirq
          <idle>-0     [00] 28991519114155384 [+   93]: tiqdio_inbound_processing <-tasklet_action
          <idle>-0     [00] 28991519114155478 [+   93]: qdio_perf_stat_inc <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114155571 [+  125]: qdio_sync_after_thinint <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114155696 [+   93]: qdio_siga_sync <-qdio_sync_after_thinint
          <idle>-0     [00] 28991519114155790 [+  125]: qdio_check_outbound_after_thinint <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114155915 [+  125]: __tasklet_schedule <-qdio_check_outbound_after_thinint
          <idle>-0     [00] 28991519114156040 [+  218]: qdio_inbound_q_moved <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114156259 [+   93]: qdio_kick_inbound_handler <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114156353 [+   93]: qdio_perf_stat_inc <-qdio_kick_inbound_handler
          <idle>-0     [00] 28991519114156446 [+  156]: qeth_l3_qdio_input_handler <-qdio_kick_inbound_handler
          <idle>-0     [00] 28991519114156603 [+  218]: qeth_core_get_next_skb <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114156821 [+   62]: dev_alloc_skb <-qeth_core_get_next_skb
          <idle>-0     [00] 28991519114156884 [+  125]: __alloc_skb <-dev_alloc_skb
          <idle>-0     [00] 28991519114157009 [+   93]: kmem_cache_alloc <-__alloc_skb
          <idle>-0     [00] 28991519114157103 [+  187]: __kmalloc <-__alloc_skb
          <idle>-0     [00] 28991519114157290 [+  187]: skb_put <-qeth_core_get_next_skb
          <idle>-0     [00] 28991519114157478 [+   93]: eth_header <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114157571 [+   93]: skb_push <-eth_header
          <idle>-0     [00] 28991519114157665 [+   93]: eth_type_trans <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114157759 [+  125]: skb_pull <-eth_type_trans
          <idle>-0     [00] 28991519114157884 [+   93]: netif_rx <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114157978 [+  125]: __napi_schedule <-netif_rx
          <idle>-0     [00] 28991519114158103 [+  125]: qeth_core_get_next_skb <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114158228 [+  125]: qeth_queue_input_buffer <-qeth_l3_qdio_input_handler
          <idle>-0     [00] 28991519114158353 [+   62]: qdio_siga_sync_q <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114158415 [+  125]: qdio_siga_sync <-qdio_siga_sync_q
          <idle>-0     [00] 28991519114158540 [+   93]: get_buf_state <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114158634 [+   93]: qdio_stop_polling <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114158728 [+  125]: qdio_perf_stat_inc <-qdio_stop_polling
          <idle>-0     [00] 28991519114158853 [+   93]: qdio_siga_sync_q <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114158946 [+   93]: qdio_siga_sync <-qdio_siga_sync_q
          <idle>-0     [00] 28991519114159040 [+  156]: get_buf_state <-tiqdio_inbound_processing
          <idle>-0     [00] 28991519114159196 [+   93]: net_rx_action <-__do_softirq
          <idle>-0     [00] 28991519114159290 [+   93]: process_backlog <-net_rx_action
          <idle>-0     [00] 28991519114159384 [+  156]: netif_receive_skb <-process_backlog
          <idle>-0     [00] 28991519114159540 [+  125]: ip_rcv <-netif_receive_skb
          <idle>-0     [00] 28991519114159665 [+  125]: ip_rcv_finish <-ip_rcv
          <idle>-0     [00] 28991519114159790 [+  156]: ip_route_input <-ip_rcv_finish
          <idle>-0     [00] 28991519114159946 [+   62]: ip_local_deliver <-ip_rcv_finish
          <idle>-0     [00] 28991519114160009 [+   93]: ip_local_deliver_finish <-ip_local_deliver
          <idle>-0     [00] 28991519114160103 [+  125]: raw_local_deliver <-ip_local_deliver_finish
          <idle>-0     [00] 28991519114160228 [+   93]: tcp_v4_rcv <-ip_local_deliver_finish
          <idle>-0     [00] 28991519114160321 [+  125]: __inet_lookup_established <-tcp_v4_rcv
          <idle>-0     [00] 28991519114160446 [+  125]: _read_lock <-__inet_lookup_established
          <idle>-0     [00] 28991519114160571 [+   93]: sk_filter <-tcp_v4_rcv
          <idle>-0     [00] 28991519114160665 [+   93]: security_sock_rcv_skb <-sk_filter
          <idle>-0     [00] 28991519114160759 [+   62]: cap_socket_sock_rcv_skb <-security_sock_rcv_skb
          <idle>-0     [00] 28991519114160821 [+  125]: local_bh_disable <-sk_filter
          <idle>-0     [00] 28991519114160946 [+   93]: local_bh_enable <-sk_filter
          <idle>-0     [00] 28991519114161040 [+   93]: _spin_lock <-tcp_v4_rcv
          <idle>-0     [00] 28991519114161134 [+   93]: __wake_up <-tcp_v4_rcv
          <idle>-0     [00] 28991519114161228 [+   93]: _spin_lock_irqsave <-__wake_up
          <idle>-0     [00] 28991519114161321 [+   93]: __wake_up_common <-__wake_up
          <idle>-0     [00] 28991519114161415 [+   93]: autoremove_wake_function <-__wake_up_common
          <idle>-0     [00] 28991519114161509 [+   62]: default_wake_function <-autoremove_wake_function
          <idle>-0     [00] 28991519114161571 [+  125]: try_to_wake_up <-default_wake_function
          <idle>-0     [00] 28991519114161696 [+   62]: task_rq_lock <-try_to_wake_up
          <idle>-0     [00] 28991519114161759 [+  125]: _spin_lock <-task_rq_lock
          <idle>-0     [00] 28991519114161884 [+  125]: select_task_rq_fair <-try_to_wake_up
          <idle>-0     [00] 28991519114162009 [+   93]: sched_clock_cpu <-try_to_wake_up
          <idle>-0     [00] 28991519114162103 [+   93]: sched_clock <-sched_clock_cpu
          <idle>-0     [00] 28991519114162196 [+   93]: activate_task <-try_to_wake_up
          <idle>-0     [00] 28991519114162290 [+   93]: enqueue_task <-activate_task
          <idle>-0     [00] 28991519114162384 [+   93]: enqueue_task_fair <-enqueue_task
          <idle>-0     [00] 28991519114162478 [+   93]: enqueue_entity <-enqueue_task_fair
          <idle>-0     [00] 28991519114162571 [+   93]: update_curr <-enqueue_entity
          <idle>-0     [00] 28991519114162665 [+   93]: place_entity <-enqueue_entity
          <idle>-0     [00] 28991519114162759 [+   93]: account_scheduler_latency <-enqueue_entity
          <idle>-0     [00] 28991519114162853 [+   93]: __enqueue_entity <-enqueue_entity
          <idle>-0     [00] 28991519114162946 [+   93]: rb_insert_color <-__enqueue_entity
          <idle>-0     [00] 28991519114163040 [+  125]: hrtick_start_fair <-enqueue_task_fair
          <idle>-0     [00] 28991519114163165 [+   93]: check_preempt_curr_idle <-try_to_wake_up
          <idle>-0     [00] 28991519114163259 [+   62]: resched_task <-check_preempt_curr_idle
          <idle>-0     [00] 28991519114163321 [+  125]: _spin_unlock_irqrestore <-try_to_wake_up
          <idle>-0     [00] 28991519114163446 [+   93]: _spin_unlock_irqrestore <-__wake_up
          <idle>-0     [00] 28991519114163540 [+   93]: sk_reset_timer <-tcp_v4_rcv
          <idle>-0     [00] 28991519114163634 [+  125]: mod_timer <-sk_reset_timer
          <idle>-0     [00] 28991519114163759 [+  125]: __timer_stats_timer_set_start_info <-mod_timer
          <idle>-0     [00] 28991519114163884 [+  125]: __mod_timer <-mod_timer
          <idle>-0     [00] 28991519114164009 [+  125]: __timer_stats_timer_set_start_info <-__mod_timer
          <idle>-0     [00] 28991519114164134 [+  125]: lock_timer_base <-__mod_timer
          <idle>-0     [00] 28991519114164259 [+  125]: _spin_lock_irqsave <-lock_timer_base
          <idle>-0     [00] 28991519114164384 [+  125]: internal_add_timer <-__mod_timer
          <idle>-0     [00] 28991519114164509 [+  281]: _spin_unlock_irqrestore <-__mod_timer
          <idle>-0     [00] 28991519114164790 [+  156]: tasklet_action <-__do_softirq
          <idle>-0     [00] 28991519114164946 [+  125]: qdio_outbound_processing <-tasklet_action
          <idle>-0     [00] 28991519114165071 [+  250]: qdio_perf_stat_inc <-qdio_outbound_processing
          <idle>-0     [00] 28991519114165321 [+  187]: qeth_qdio_output_handler <-qdio_outbound_processing
          <idle>-0     [00] 28991519114165509 [+  125]: qeth_check_qdio_errors <-qeth_qdio_output_handler
          <idle>-0     [00] 28991519114165634 [+  125]: qeth_clear_output_buffer <-qeth_qdio_output_handler
          <idle>-0     [00] 28991519114165759 [+   93]: skb_dequeue <-qeth_clear_output_buffer
          <idle>-0     [00] 28991519114165853 [+  125]: _spin_lock_irqsave <-skb_dequeue
          <idle>-0     [00] 28991519114165978 [+  156]: _spin_unlock_irqrestore <-skb_dequeue
          <idle>-0     [00] 28991519114166134 [+  156]: dev_kfree_skb_any <-qeth_clear_output_buffer
          <idle>-0     [00] 28991519114166290 [+  125]: kfree_skb <-dev_kfree_skb_any
          <idle>-0     [00] 28991519114166415 [+  125]: __kfree_skb <-kfree_skb
          <idle>-0     [00] 28991519114166540 [+  125]: skb_release_all <-__kfree_skb
          <idle>-0     [00] 28991519114166665 [+  125]: dst_release <-skb_release_all
          <idle>-0     [00] 28991519114166790 [+  125]: skb_release_data <-skb_release_all
          <idle>-0     [00] 28991519114166915 [+  218]: kfree <-skb_release_data
          <idle>-0     [00] 28991519114167134 [+  156]: kmem_cache_free <-__kfree_skb
          <idle>-0     [00] 28991519114167290 [+  125]: skb_dequeue <-qeth_clear_output_buffer
          <idle>-0     [00] 28991519114167415 [+  125]: _spin_lock_irqsave <-skb_dequeue
          <idle>-0     [00] 28991519114167540 [+  125]: _spin_unlock_irqrestore <-skb_dequeue
          <idle>-0     [00] 28991519114167665 [+  312]: qeth_eddp_buf_release_contexts <-qeth_clear_output_buffer
          <idle>-0     [00] 28991519114167978 [+  156]: qeth_switch_to_nonpacking_if_needed <-qeth_qdio_output_handler
          <idle>-0     [00] 28991519114168134 [+  125]: __netif_schedule <-qeth_qdio_output_handler
          <idle>-0     [00] 28991519114168259 [+  156]: raise_softirq_irqoff <-__netif_schedule
          <idle>-0     [00] 28991519114168415 [+  125]: del_timer <-qdio_outbound_processing
          <idle>-0     [00] 28991519114168540 [+   93]: lock_timer_base <-del_timer
          <idle>-0     [00] 28991519114168634 [+  156]: _spin_lock_irqsave <-lock_timer_base
          <idle>-0     [00] 28991519114168790 [+  218]: _spin_unlock_irqrestore <-del_timer
          <idle>-0     [00] 28991519114169009 [+  187]: net_tx_action <-__do_softirq
          <idle>-0     [00] 28991519114169196 [+  125]: _spin_trylock <-net_tx_action
          <idle>-0     [00] 28991519114169321 [+  125]: __qdisc_run <-net_tx_action
          <idle>-0     [00] 28991519114169446 [+  156]: pfifo_fast_dequeue <-__qdisc_run
          <idle>-0     [00] 28991519114169603 [+   93]: account_system_vtime <-__do_softirq
          <idle>-0     [00] 28991519114169696 [+  125]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28991519114169821 [+   93]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28991519114169915 [+  125]: _local_bh_enable <-__do_softirq
          <idle>-0     [00] 28991519114170040 [+  187]: idle_cpu <-irq_exit
          <idle>-0     [00] 28991519114170228 [+  125]: tick_nohz_restart_sched_tick <-cpu_idle
          <idle>-0     [00] 28991519114170353 [+   93]: tick_nohz_stop_idle <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114170446 [+   93]: select_nohz_load_balancer <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114170540 [+   93]: ktime_get <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114170634 [+  125]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519114170759 [+   62]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519114170821 [+  156]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519114170978 [+   93]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519114171071 [+  125]: tick_do_update_jiffies64 <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114171196 [+   93]: hrtimer_cancel <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114171290 [+   93]: hrtimer_try_to_cancel <-hrtimer_cancel
          <idle>-0     [00] 28991519114171384 [+   62]: lock_hrtimer_base <-hrtimer_try_to_cancel
          <idle>-0     [00] 28991519114171446 [+  125]: _spin_lock_irqsave <-lock_hrtimer_base
          <idle>-0     [00] 28991519114171571 [+   93]: __remove_hrtimer <-hrtimer_try_to_cancel
          <idle>-0     [00] 28991519114171665 [+   93]: rb_next <-__remove_hrtimer
          <idle>-0     [00] 28991519114171759 [+   93]: hrtimer_force_reprogram <-__remove_hrtimer
          <idle>-0     [00] 28991519114171853 [+   93]: tick_program_event <-hrtimer_force_reprogram
          <idle>-0     [00] 28991519114171946 [+   93]: tick_dev_program_event <-tick_program_event
          <idle>-0     [00] 28991519114172040 [+  125]: ktime_get <-tick_dev_program_event
          <idle>-0     [00] 28991519114172165 [+   62]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519114172228 [+   93]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519114172321 [+   93]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519114172415 [+  156]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519114172571 [+   93]: clockevents_program_event <-tick_dev_program_event
          <idle>-0     [00] 28991519114172665 [+  125]: s390_next_event <-clockevents_program_event
          <idle>-0     [00] 28991519114172790 [+  125]: rb_erase <-__remove_hrtimer
          <idle>-0     [00] 28991519114172915 [+   93]: _spin_unlock_irqrestore <-hrtimer_try_to_cancel
          <idle>-0     [00] 28991519114173009 [+   93]: hrtimer_forward <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114173103 [+  125]: hrtimer_start <-tick_nohz_restart_sched_tick
          <idle>-0     [00] 28991519114173228 [+   62]: lock_hrtimer_base <-hrtimer_start
          <idle>-0     [00] 28991519114173290 [+  125]: _spin_lock_irqsave <-lock_hrtimer_base
          <idle>-0     [00] 28991519114173415 [+   93]: __timer_stats_hrtimer_set_start_info <-hrtimer_start
          <idle>-0     [00] 28991519114173509 [+   93]: enqueue_hrtimer <-hrtimer_start
          <idle>-0     [00] 28991519114173603 [+   93]: hrtimer_reprogram <-enqueue_hrtimer
          <idle>-0     [00] 28991519114173696 [+   93]: tick_program_event <-hrtimer_reprogram
          <idle>-0     [00] 28991519114173790 [+   93]: tick_dev_program_event <-tick_program_event
          <idle>-0     [00] 28991519114173884 [+   62]: ktime_get <-tick_dev_program_event
          <idle>-0     [00] 28991519114173946 [+   93]: ktime_get_ts <-ktime_get
          <idle>-0     [00] 28991519114174040 [+   93]: getnstimeofday <-ktime_get_ts
          <idle>-0     [00] 28991519114174134 [+   93]: read_tod_clock <-getnstimeofday
          <idle>-0     [00] 28991519114174228 [+   93]: set_normalized_timespec <-ktime_get_ts
          <idle>-0     [00] 28991519114174321 [+  125]: clockevents_program_event <-tick_dev_program_event
          <idle>-0     [00] 28991519114174446 [+  125]: s390_next_event <-clockevents_program_event
          <idle>-0     [00] 28991519114174571 [+   93]: rb_insert_color <-enqueue_hrtimer
          <idle>-0     [00] 28991519114174665 [+  156]: _spin_unlock_irqrestore <-hrtimer_start
          <idle>-0     [00] 28991519114174821 [+  125]: schedule <-cpu_idle
          <idle>-0     [00] 28991519114174946 [+   93]: _spin_lock <-schedule
          <idle>-0     [00] 28991519114175040 [+  125]: sched_clock_cpu <-schedule
          <idle>-0     [00] 28991519114175165 [+  125]: sched_clock <-sched_clock_cpu
          <idle>-0     [00] 28991519114175290 [+   93]: put_prev_task_idle <-schedule
          <idle>-0     [00] 28991519114175384 [+   93]: pick_next_task_fair <-schedule
          <idle>-0     [00] 28991519114175478 [+   93]: set_next_entity <-pick_next_task_fair
          <idle>-0     [00] 28991519114175571 [+   93]: __dequeue_entity <-set_next_entity
          <idle>-0     [00] 28991519114175665 [+   93]: rb_next <-__dequeue_entity
          <idle>-0     [00] 28991519114175759 [+  125]: rb_erase <-__dequeue_entity
          <idle>-0     [00] 28991519114175884 [+  187]: hrtick_start_fair <-pick_next_task_fair
          <idle>-0     [00] 28991519114176071 [+  187]: _spin_trylock <-tracing_record_cmdline
            perl-2581  [00] 28991519114176259 [+  125]: finish_task_switch <-schedule
            perl-2581  [00] 28991519114176384 [+   93]: account_vtime <-finish_task_switch
            perl-2581  [00] 28991519114176478 [+   93]: account_user_time <-account_vtime
            perl-2581  [00] 28991519114176571 [+   93]: acct_update_integrals <-account_user_time
            perl-2581  [00] 28991519114176665 [+  125]: account_system_time <-account_vtime
            perl-2581  [00] 28991519114176790 [+  156]: acct_update_integrals <-account_system_time
            perl-2581  [00] 28991519114176946 [+  125]: lock_sock_nested <-sk_wait_data
            perl-2581  [00] 28991519114177071 [+  125]: _spin_lock_bh <-lock_sock_nested
            perl-2581  [00] 28991519114177196 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519114177321 [+  187]: local_bh_enable <-lock_sock_nested
            perl-2581  [00] 28991519114177509 [+  156]: finish_wait <-sk_wait_data
            perl-2581  [00] 28991519114177665 [+  125]: tcp_prequeue_process <-tcp_recvmsg
            perl-2581  [00] 28991519114177790 [+  156]: local_bh_disable <-tcp_prequeue_process
            perl-2581  [00] 28991519114177946 [+  125]: tcp_v4_do_rcv <-tcp_prequeue_process
            perl-2581  [00] 28991519114178071 [+  125]: tcp_rcv_established <-tcp_v4_do_rcv
            perl-2581  [00] 28991519114178196 [+  156]: local_bh_enable <-tcp_rcv_established
            perl-2581  [00] 28991519114178353 [+  125]: skb_copy_datagram_iovec <-tcp_rcv_established
            perl-2581  [00] 28991519114178478 [+  125]: memcpy_toiovec <-skb_copy_datagram_iovec
            perl-2581  [00] 28991519114178603 [+  125]: copy_to_user_mvcos_check <-memcpy_toiovec
            perl-2581  [00] 28991519114178728 [+  187]: copy_to_user_std <-copy_to_user_mvcos_check
            perl-2581  [00] 28991519114178915 [+   93]: tcp_rcv_space_adjust <-tcp_rcv_established
            perl-2581  [00] 28991519114179009 [+  156]: local_bh_disable <-tcp_rcv_established
            perl-2581  [00] 28991519114179165 [+  125]: get_seconds <-tcp_rcv_established
            perl-2581  [00] 28991519114179290 [+  156]: tcp_event_data_recv <-tcp_rcv_established
            perl-2581  [00] 28991519114179446 [+  187]: tcp_ack <-tcp_rcv_established
            perl-2581  [00] 28991519114179634 [+  156]: __kfree_skb <-tcp_ack
            perl-2581  [00] 28991519114179790 [+   93]: skb_release_all <-__kfree_skb
            perl-2581  [00] 28991519114179884 [+  125]: dst_release <-skb_release_all
            perl-2581  [00] 28991519114180009 [+  156]: skb_release_data <-skb_release_all
            perl-2581  [00] 28991519114180165 [+  187]: kfree <-skb_release_data
            perl-2581  [00] 28991519114180353 [+  187]: kmem_cache_free <-__kfree_skb
            perl-2581  [00] 28991519114180540 [+  125]: tcp_rtt_estimator <-tcp_ack
            perl-2581  [00] 28991519114180665 [+  156]: bictcp_acked <-tcp_ack
            perl-2581  [00] 28991519114180821 [+   93]: bictcp_cong_avoid <-tcp_ack
            perl-2581  [00] 28991519114180915 [+  156]: tcp_is_cwnd_limited <-bictcp_cong_avoid
            perl-2581  [00] 28991519114181071 [+  125]: tcp_current_mss <-tcp_rcv_established
            perl-2581  [00] 28991519114181196 [+  125]: tcp_established_options <-tcp_current_mss
            perl-2581  [00] 28991519114181321 [+  125]: __tcp_push_pending_frames <-tcp_rcv_established
            perl-2581  [00] 28991519114181446 [+  125]: __tcp_ack_snd_check <-tcp_rcv_established
            perl-2581  [00] 28991519114181571 [+  125]: tcp_send_delayed_ack <-__tcp_ack_snd_check
            perl-2581  [00] 28991519114181696 [+  125]: sk_reset_timer <-tcp_send_delayed_ack
            perl-2581  [00] 28991519114181821 [+  125]: mod_timer <-sk_reset_timer
            perl-2581  [00] 28991519114181946 [+  125]: __timer_stats_timer_set_start_info <-mod_timer
            perl-2581  [00] 28991519114182071 [+   93]: __mod_timer <-mod_timer
            perl-2581  [00] 28991519114182165 [+  156]: __timer_stats_timer_set_start_info <-__mod_timer
            perl-2581  [00] 28991519114182321 [+   93]: lock_timer_base <-__mod_timer
            perl-2581  [00] 28991519114182415 [+  156]: _spin_lock_irqsave <-lock_timer_base
            perl-2581  [00] 28991519114182571 [+   93]: internal_add_timer <-__mod_timer
            perl-2581  [00] 28991519114182665 [+  156]: _spin_unlock_irqrestore <-__mod_timer
            perl-2581  [00] 28991519114182821 [+   93]: __kfree_skb <-tcp_rcv_established
            perl-2581  [00] 28991519114182915 [+  125]: skb_release_all <-__kfree_skb
            perl-2581  [00] 28991519114183040 [+  125]: dst_release <-skb_release_all
            perl-2581  [00] 28991519114183165 [+  125]: skb_release_data <-skb_release_all
            perl-2581  [00] 28991519114183290 [+  187]: kfree <-skb_release_data
            perl-2581  [00] 28991519114183478 [+  187]: kmem_cache_free <-__kfree_skb
            perl-2581  [00] 28991519114183665 [+  187]: local_bh_enable <-tcp_prequeue_process
            perl-2581  [00] 28991519114183853 [+  125]: tcp_cleanup_rbuf <-tcp_recvmsg
            perl-2581  [00] 28991519114183978 [+  156]: __tcp_select_window <-tcp_cleanup_rbuf
            perl-2581  [00] 28991519114184134 [+  125]: release_sock <-tcp_recvmsg
            perl-2581  [00] 28991519114184259 [+   93]: _spin_lock_bh <-release_sock
            perl-2581  [00] 28991519114184353 [+  125]: local_bh_disable <-_spin_lock_bh
            perl-2581  [00] 28991519114184478 [+  156]: _spin_unlock_bh <-release_sock
            perl-2581  [00] 28991519114184634 [+  218]: local_bh_enable_ip <-_spin_unlock_bh
            perl-2581  [00] 28991519114184853 [+  156]: dnotify_parent <-vfs_read
            perl-2581  [00] 28991519114185009 [+  125]: _spin_lock <-dnotify_parent
            perl-2581  [00] 28991519114185134 [+  125]: inotify_dentry_parent_queue_event <-vfs_read
            perl-2581  [00] 28991519114185259 [+ 1687]: inotify_inode_queue_event <-vfs_read

And this is for 2.6.16:

# tracer: ftrace
#
#           TASK-PID   CPU#    TIMESTAMP  FUNCTION
#              | |      |          |         |
           <...>-2804  [00] 28994586831213199 [+   93]: sys_write <-sysc_noemu
           <...>-2804  [00] 28994586831213292 [+  218]: fget_light <-sys_write
           <...>-2804  [00] 28994586831213511 [+  156]: apparmor_file_permission <-sys_write
           <...>-2804  [00] 28994586831213667 [+  125]: sock_aio_write <-sys_write
           <...>-2804  [00] 28994586831213792 [+  125]: dummy_socket_sendmsg <-sock_aio_write
           <...>-2804  [00] 28994586831213917 [+  125]: inet_sendmsg <-sock_aio_write
           <...>-2804  [00] 28994586831214042 [+   93]: tcp_sendmsg <-inet_sendmsg
           <...>-2804  [00] 28994586831214136 [+  125]: lock_sock <-tcp_sendmsg
           <...>-2804  [00] 28994586831214261 [+  125]: _spin_lock_bh <-lock_sock
           <...>-2804  [00] 28994586831214386 [+  125]: _spin_unlock_bh <-lock_sock
           <...>-2804  [00] 28994586831214511 [+  187]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831214699 [+  156]: tcp_current_mss <-tcp_sendmsg
           <...>-2804  [00] 28994586831214855 [+  125]: __alloc_skb <-tcp_sendmsg
           <...>-2804  [00] 28994586831214980 [+  156]: kmem_cache_alloc <-__alloc_skb
           <...>-2804  [00] 28994586831215136 [+  218]: __kmalloc <-__alloc_skb
           <...>-2804  [00] 28994586831215355 [+  187]: memset <-__alloc_skb
           <...>-2804  [00] 28994586831215542 [+  125]: copy_from_user_mvcos_check <-tcp_sendmsg
           <...>-2804  [00] 28994586831215667 [+  218]: copy_from_user_std <-copy_from_user_mvcos_check
           <...>-2804  [00] 28994586831215886 [+  125]: __tcp_push_pending_frames <-tcp_sendmsg
           <...>-2804  [00] 28994586831216011 [+  125]: tcp_transmit_skb <-__tcp_push_pending_frames
           <...>-2804  [00] 28994586831216136 [+  156]: skb_clone <-tcp_transmit_skb
           <...>-2804  [00] 28994586831216292 [+  250]: memcpy <-skb_clone
           <...>-2804  [00] 28994586831216542 [+  156]: tcp_v4_send_check <-tcp_transmit_skb
           <...>-2804  [00] 28994586831216699 [+  187]: ip_queue_xmit <-tcp_transmit_skb
           <...>-2804  [00] 28994586831216886 [+  187]: ip_output <-ip_queue_xmit
           <...>-2804  [00] 28994586831217074 [+  125]: dev_queue_xmit <-ip_output
           <...>-2804  [00] 28994586831217199 [+  125]: _spin_lock <-dev_queue_xmit
           <...>-2804  [00] 28994586831217324 [+  125]: pfifo_fast_enqueue <-dev_queue_xmit
           <...>-2804  [00] 28994586831217449 [+  125]: __qdisc_run <-dev_queue_xmit
           <...>-2804  [00] 28994586831217574 [+  156]: pfifo_fast_dequeue <-__qdisc_run
           <...>-2804  [00] 28994586831217730 [+  125]: _spin_trylock <-__qdisc_run
           <...>-2804  [00] 28994586831217855 [+  156]: dev_hard_start_xmit <-__qdisc_run
           <...>-2804  [00] 28994586831218011 [+  250]: qeth_hard_start_xmit <-dev_hard_start_xmit
           <...>-2804  [00] 28994586831218261 [+  125]: qeth_fill_header <-qeth_hard_start_xmit
           <...>-2804  [00] 28994586831218386 [+  156]: memset <-qeth_fill_header
           <...>-2804  [00] 28994586831218542 [+  187]: memset <-qeth_fill_header
           <...>-2804  [00] 28994586831218730 [+  125]: skb_queue_tail <-qeth_hard_start_xmit
           <...>-2804  [00] 28994586831218855 [+  125]: _spin_lock_irqsave <-skb_queue_tail
           <...>-2804  [00] 28994586831218980 [+  156]: _spin_unlock_irqrestore <-skb_queue_tail
           <...>-2804  [00] 28994586831219136 [+  218]: qeth_flush_buffers <-qeth_hard_start_xmit
           <...>-2804  [00] 28994586831219355 [+  875]: do_QDIO <-qeth_flush_buffers
           <...>-2804  [00] 28994586831220230 [+   93]: mod_timer <-do_QDIO
           <...>-2804  [00] 28994586831220324 [+  187]: _spin_lock_irqsave <-mod_timer
           <...>-2804  [00] 28994586831220511 [+  187]: _spin_unlock_irqrestore <-mod_timer
           <...>-2804  [00] 28994586831220699 [+  125]: raise_softirq_irqoff <-qeth_hard_start_xmit
           <...>-2804  [00] 28994586831220824 [+  156]: _spin_lock <-__qdisc_run
           <...>-2804  [00] 28994586831220980 [+  125]: pfifo_fast_dequeue <-__qdisc_run
           <...>-2804  [00] 28994586831221105 [+  156]: local_bh_enable <-dev_queue_xmit
           <...>-2804  [00] 28994586831221261 [+  156]: do_softirq <-local_bh_enable
           <...>-2804  [00] 28994586831221417 [+   93]: account_system_vtime <-do_softirq
           <...>-2804  [00] 28994586831221511 [+   93]: account_system_time <-account_system_vtime
           <...>-2804  [00] 28994586831221605 [+  125]: acct_update_integrals <-account_system_time
           <...>-2804  [00] 28994586831221730 [+  156]: __do_softirq <-do_softirq
           <...>-2804  [00] 28994586831221886 [+  156]: net_tx_action <-__do_softirq
           <...>-2804  [00] 28994586831222042 [+  125]: _spin_trylock <-net_tx_action
           <...>-2804  [00] 28994586831222167 [+  125]: __qdisc_run <-net_tx_action
           <...>-2804  [00] 28994586831222292 [+  156]: pfifo_fast_dequeue <-__qdisc_run
           <...>-2804  [00] 28994586831222449 [+   93]: account_system_vtime <-do_softirq
           <...>-2804  [00] 28994586831222542 [+  125]: account_system_time <-account_system_vtime
           <...>-2804  [00] 28994586831222667 [+  156]: acct_update_integrals <-account_system_time
           <...>-2804  [00] 28994586831222824 [+  125]: sk_reset_timer <-__tcp_push_pending_frames
           <...>-2804  [00] 28994586831222949 [+  156]: mod_timer <-sk_reset_timer
           <...>-2804  [00] 28994586831223105 [+  125]: release_sock <-tcp_sendmsg
           <...>-2804  [00] 28994586831223230 [+   93]: _spin_lock_bh <-release_sock
           <...>-2804  [00] 28994586831223324 [+  156]: _spin_unlock_bh <-release_sock
           <...>-2804  [00] 28994586831223480 [+  187]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831223667 [+   93]: dnotify_parent <-sys_write
           <...>-2804  [00] 28994586831223761 [+  125]: _spin_lock <-dnotify_parent
           <...>-2804  [00] 28994586831223886 [+  156]: inotify_dentry_parent_queue_event <-sys_write
           <...>-2804  [00] 28994586831224042 [+  812]: inotify_inode_queue_event <-sys_write
           <...>-2804  [00] 28994586831224855 [+   93]: sys_read <-sysc_noemu
           <...>-2804  [00] 28994586831224949 [+  187]: fget_light <-sys_read
           <...>-2804  [00] 28994586831225136 [+  125]: apparmor_file_permission <-sys_read
           <...>-2804  [00] 28994586831225261 [+  125]: sock_aio_read <-sys_read
           <...>-2804  [00] 28994586831225386 [+  156]: dummy_socket_recvmsg <-sock_aio_read
           <...>-2804  [00] 28994586831225542 [+   93]: sock_common_recvmsg <-sock_aio_read
           <...>-2804  [00] 28994586831225636 [+  125]: tcp_recvmsg <-sock_common_recvmsg
           <...>-2804  [00] 28994586831225761 [+  125]: lock_sock <-tcp_recvmsg
           <...>-2804  [00] 28994586831225886 [+  125]: _spin_lock_bh <-lock_sock
           <...>-2804  [00] 28994586831226011 [+  125]: _spin_unlock_bh <-lock_sock
           <...>-2804  [00] 28994586831226136 [+  250]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831226386 [+  125]: sk_wait_data <-tcp_recvmsg
           <...>-2804  [00] 28994586831226511 [+  125]: prepare_to_wait <-sk_wait_data
           <...>-2804  [00] 28994586831226636 [+  156]: _spin_lock_irqsave <-prepare_to_wait
           <...>-2804  [00] 28994586831226792 [+  156]: _spin_unlock_irqrestore <-prepare_to_wait
           <...>-2804  [00] 28994586831226949 [+   93]: _spin_lock_bh <-sk_wait_data
           <...>-2804  [00] 28994586831227042 [+  125]: _spin_unlock_bh <-sk_wait_data
           <...>-2804  [00] 28994586831227167 [+  187]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831227355 [+  125]: schedule_timeout <-sk_wait_data
           <...>-2804  [00] 28994586831227480 [+   93]: schedule <-schedule_timeout
           <...>-2804  [00] 28994586831227574 [+  156]: profile_hit <-schedule
           <...>-2804  [00] 28994586831227730 [+  156]: sched_clock <-schedule
           <...>-2804  [00] 28994586831227886 [+  281]: _spin_lock_irq <-schedule
          <idle>-0     [00] 28994586831228167 [+   93]: account_vtime <-schedule
          <idle>-0     [00] 28994586831228261 [+   93]: account_user_time <-account_vtime
          <idle>-0     [00] 28994586831228355 [+   93]: account_system_time <-account_vtime
          <idle>-0     [00] 28994586831228449 [+  218]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28994586831228667 [+   93]: notifier_call_chain <-cpu_idle
          <idle>-0     [00] 28994586831228761 [+   93]: nohz_idle_notify <-notifier_call_chain
          <idle>-0     [00] 28994586831228855 [+  156]: rcu_needs_cpu <-nohz_idle_notify
          <idle>-0     [00] 28994586831229011 [+   62]: next_timer_interrupt <-nohz_idle_notify
          <idle>-0     [00] 28994586831229074 [+   93]: hrtimer_get_next_event <-next_timer_interrupt
          <idle>-0     [00] 28994586831229167 [+  125]: _spin_lock_irqsave <-hrtimer_get_next_event
          <idle>-0     [00] 28994586831229292 [+   93]: _spin_unlock_irqrestore <-hrtimer_get_next_event
          <idle>-0     [00] 28994586831229386 [+   93]: _spin_lock_irqsave <-hrtimer_get_next_event
          <idle>-0     [00] 28994586831229480 [+   93]: _spin_unlock_irqrestore <-hrtimer_get_next_event
          <idle>-0     [00] 28994586831229574 [+  125]: ktime_get <-hrtimer_get_next_event
          <idle>-0     [00] 28994586831229699 [+   93]: getnstimeofday <-ktime_get
          <idle>-0     [00] 28994586831229792 [+  156]: do_gettimeofday <-getnstimeofday
          <idle>-0     [00] 28994586831229949 [+  156]: set_normalized_timespec <-ktime_get
          <idle>-0     [00] 28994586831230105 [+  125]: ns_to_timespec <-next_timer_interrupt
          <idle>-0     [00] 28994586831230230 [+  156]: _spin_lock <-next_timer_interrupt
          <idle>-0     [00] 28994586831230386 [+212406]: vtimer_idle_notify <-notifier_call_chain
          <idle>-0     [00] 28994586831442792 [+   93]: do_IRQ <-io_return
          <idle>-0     [00] 28994586831442886 [+   62]: account_system_vtime <-do_IRQ
          <idle>-0     [00] 28994586831442949 [+  125]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28994586831443074 [+  250]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28994586831443324 [+   93]: do_monitor_call <-sysc_return
          <idle>-0     [00] 28994586831443417 [+   62]: notifier_call_chain <-do_monitor_call
          <idle>-0     [00] 28994586831443480 [+  156]: nohz_idle_notify <-notifier_call_chain
          <idle>-0     [00] 28994586831443636 [+  125]: vtimer_idle_notify <-notifier_call_chain
          <idle>-0     [00] 28994586831443761 [+  125]: do_adapter_IO <-do_IRQ
          <idle>-0     [00] 28994586831443886 [+  500]: tiqdio_thinint_handler <-do_adapter_IO
          <idle>-0     [00] 28994586831444386 [+  156]: qeth_qdio_output_handler <-tiqdio_thinint_handler
          <idle>-0     [00] 28994586831444542 [+   62]: skb_dequeue <-qeth_qdio_output_handler
          <idle>-0     [00] 28994586831444605 [+  125]: _spin_lock_irqsave <-skb_dequeue
          <idle>-0     [00] 28994586831444730 [+  125]: _spin_unlock_irqrestore <-skb_dequeue
          <idle>-0     [00] 28994586831444855 [+   93]: raise_softirq_irqoff <-qeth_qdio_output_handler
          <idle>-0     [00] 28994586831444949 [+   93]: skb_dequeue <-qeth_qdio_output_handler
          <idle>-0     [00] 28994586831445042 [+   93]: _spin_lock_irqsave <-skb_dequeue
          <idle>-0     [00] 28994586831445136 [+   93]: _spin_unlock_irqrestore <-skb_dequeue
          <idle>-0     [00] 28994586831445230 [+  250]: qeth_eddp_buf_release_contexts <-qeth_qdio_output_handler
          <idle>-0     [00] 28994586831445480 [+  125]: raise_softirq_irqoff <-qeth_qdio_output_handler
          <idle>-0     [00] 28994586831445605 [+   93]: del_timer <-tiqdio_thinint_handler
          <idle>-0     [00] 28994586831445699 [+  125]: _spin_lock_irqsave <-del_timer
          <idle>-0     [00] 28994586831445824 [+  218]: _spin_unlock_irqrestore <-del_timer
          <idle>-0     [00] 28994586831446042 [+  250]: qeth_qdio_input_handler <-tiqdio_thinint_handler
          <idle>-0     [00] 28994586831446292 [+   62]: __alloc_skb <-qeth_qdio_input_handler
          <idle>-0     [00] 28994586831446355 [+  125]: kmem_cache_alloc <-__alloc_skb
          <idle>-0     [00] 28994586831446480 [+  125]: __kmalloc <-__alloc_skb
          <idle>-0     [00] 28994586831446605 [+  156]: memset <-__alloc_skb
          <idle>-0     [00] 28994586831446761 [+  187]: memcpy <-qeth_qdio_input_handler
          <idle>-0     [00] 28994586831446949 [+  500]: netif_rx <-qeth_qdio_input_handler
          <idle>-0     [00] 28994586831447449 [+   93]: irq_exit <-do_IRQ
          <idle>-0     [00] 28994586831447542 [+   93]: account_system_vtime <-irq_exit
          <idle>-0     [00] 28994586831447636 [+   93]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28994586831447730 [+   93]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28994586831447824 [+   93]: do_softirq <-irq_exit
          <idle>-0     [00] 28994586831447917 [+   62]: account_system_vtime <-do_softirq
          <idle>-0     [00] 28994586831447980 [+   93]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28994586831448074 [+  125]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28994586831448199 [+   93]: __do_softirq <-do_softirq
          <idle>-0     [00] 28994586831448292 [+   93]: net_tx_action <-__do_softirq
          <idle>-0     [00] 28994586831448386 [+  125]: __kfree_skb <-net_tx_action
          <idle>-0     [00] 28994586831448511 [+  156]: sock_wfree <-__kfree_skb
          <idle>-0     [00] 28994586831448667 [+   93]: _spin_trylock <-net_tx_action
          <idle>-0     [00] 28994586831448761 [+   62]: __qdisc_run <-net_tx_action
          <idle>-0     [00] 28994586831448824 [+  156]: pfifo_fast_dequeue <-__qdisc_run
          <idle>-0     [00] 28994586831448980 [+   93]: net_rx_action <-__do_softirq
          <idle>-0     [00] 28994586831449074 [+  156]: process_backlog <-net_rx_action
          <idle>-0     [00] 28994586831449230 [+  156]: ip_rcv <-process_backlog
          <idle>-0     [00] 28994586831449386 [+  125]: ip_route_input <-ip_rcv
          <idle>-0     [00] 28994586831449511 [+  125]: ip_local_deliver <-ip_rcv
          <idle>-0     [00] 28994586831449636 [+  125]: tcp_v4_rcv <-ip_local_deliver
          <idle>-0     [00] 28994586831449761 [+  125]: _read_lock <-tcp_v4_rcv
          <idle>-0     [00] 28994586831449886 [+   93]: dummy_socket_sock_rcv_skb <-tcp_v4_rcv
          <idle>-0     [00] 28994586831449980 [+   93]: _spin_lock <-tcp_v4_rcv
          <idle>-0     [00] 28994586831450074 [+   93]: __wake_up <-tcp_v4_rcv
          <idle>-0     [00] 28994586831450167 [+   93]: _spin_lock_irqsave <-__wake_up
          <idle>-0     [00] 28994586831450261 [+   93]: autoremove_wake_function <-__wake_up
          <idle>-0     [00] 28994586831450355 [+   93]: default_wake_function <-autoremove_wake_function
          <idle>-0     [00] 28994586831450449 [+  125]: _spin_lock <-default_wake_function
          <idle>-0     [00] 28994586831450574 [+  187]: sched_clock <-default_wake_function
          <idle>-0     [00] 28994586831450761 [+  125]: resched_task <-default_wake_function
          <idle>-0     [00] 28994586831450886 [+   93]: _spin_unlock_irqrestore <-default_wake_function
          <idle>-0     [00] 28994586831450980 [+   93]: _spin_unlock_irqrestore <-__wake_up
          <idle>-0     [00] 28994586831451074 [+   93]: sk_reset_timer <-tcp_v4_rcv
          <idle>-0     [00] 28994586831451167 [+   93]: mod_timer <-sk_reset_timer
          <idle>-0     [00] 28994586831451261 [+  125]: _spin_lock_irqsave <-mod_timer
          <idle>-0     [00] 28994586831451386 [+  156]: _spin_unlock_irqrestore <-mod_timer
          <idle>-0     [00] 28994586831451542 [+   93]: account_system_vtime <-do_softirq
          <idle>-0     [00] 28994586831451636 [+   93]: account_system_time <-account_system_vtime
          <idle>-0     [00] 28994586831451730 [+  156]: acct_update_integrals <-account_system_time
          <idle>-0     [00] 28994586831451886 [+  125]: schedule <-cpu_idle
          <idle>-0     [00] 28994586831452011 [+   93]: profile_hit <-schedule
          <idle>-0     [00] 28994586831452105 [+  125]: sched_clock <-schedule
          <idle>-0     [00] 28994586831452230 [+  343]: _spin_lock_irq <-schedule
           <...>-2804  [00] 28994586831452574 [+   93]: account_vtime <-schedule
           <...>-2804  [00] 28994586831452667 [+   62]: account_user_time <-account_vtime
           <...>-2804  [00] 28994586831452730 [+  125]: account_system_time <-account_vtime
           <...>-2804  [00] 28994586831452855 [+  125]: acct_update_integrals <-account_system_time
           <...>-2804  [00] 28994586831452980 [+   93]: _spin_lock_bh <-sk_wait_data
           <...>-2804  [00] 28994586831453074 [+   93]: _spin_unlock_bh <-sk_wait_data
           <...>-2804  [00] 28994586831453167 [+   93]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831453261 [+  125]: finish_wait <-sk_wait_data
           <...>-2804  [00] 28994586831453386 [+   93]: tcp_v4_do_rcv <-tcp_recvmsg
           <...>-2804  [00] 28994586831453480 [+   93]: tcp_rcv_established <-tcp_v4_do_rcv
           <...>-2804  [00] 28994586831453574 [+   93]: local_bh_enable <-tcp_rcv_established
           <...>-2804  [00] 28994586831453667 [+   93]: skb_copy_datagram_iovec <-tcp_rcv_established
           <...>-2804  [00] 28994586831453761 [+   93]: memcpy_toiovec <-skb_copy_datagram_iovec
           <...>-2804  [00] 28994586831453855 [+   62]: copy_to_user_mvcos_check <-memcpy_toiovec
           <...>-2804  [00] 28994586831453917 [+  187]: copy_to_user_std <-copy_to_user_mvcos_check
           <...>-2804  [00] 28994586831454105 [+  125]: tcp_ack <-tcp_rcv_established
           <...>-2804  [00] 28994586831454230 [+  125]: __kfree_skb <-tcp_ack
           <...>-2804  [00] 28994586831454355 [+  125]: kfree <-__kfree_skb
           <...>-2804  [00] 28994586831454480 [+  187]: kmem_cache_free <-__kfree_skb
           <...>-2804  [00] 28994586831454667 [+   93]: tcp_reno_cong_avoid <-tcp_ack
           <...>-2804  [00] 28994586831454761 [+   93]: tcp_current_mss <-tcp_rcv_established
           <...>-2804  [00] 28994586831454855 [+  156]: __tcp_push_pending_frames <-tcp_rcv_established
           <...>-2804  [00] 28994586831455011 [+   62]: tcp_send_delayed_ack <-tcp_rcv_established
           <...>-2804  [00] 28994586831455074 [+   93]: sk_reset_timer <-tcp_send_delayed_ack
           <...>-2804  [00] 28994586831455167 [+   93]: mod_timer <-sk_reset_timer
           <...>-2804  [00] 28994586831455261 [+   93]: _spin_lock_irqsave <-mod_timer
           <...>-2804  [00] 28994586831455355 [+   93]: _spin_unlock_irqrestore <-mod_timer
           <...>-2804  [00] 28994586831455449 [+  125]: __kfree_skb <-tcp_rcv_established
           <...>-2804  [00] 28994586831455574 [+   93]: kfree <-__kfree_skb
           <...>-2804  [00] 28994586831455667 [+  125]: kmem_cache_free <-__kfree_skb
           <...>-2804  [00] 28994586831455792 [+  156]: local_bh_enable <-tcp_recvmsg
           <...>-2804  [00] 28994586831455949 [+   93]: __tcp_select_window <-tcp_recvmsg
           <...>-2804  [00] 28994586831456042 [+   93]: release_sock <-tcp_recvmsg
           <...>-2804  [00] 28994586831456136 [+   93]: _spin_lock_bh <-release_sock
           <...>-2804  [00] 28994586831456230 [+   93]: _spin_unlock_bh <-release_sock
           <...>-2804  [00] 28994586831456324 [+  156]: local_bh_enable <-_spin_unlock_bh
           <...>-2804  [00] 28994586831456480 [+   93]: dnotify_parent <-sys_read
           <...>-2804  [00] 28994586831456574 [+  125]: _spin_lock <-dnotify_parent
           <...>-2804  [00] 28994586831456699 [+   62]: inotify_dentry_parent_queue_event <-sys_read
           <...>-2804  [00] 28994586831456761 [+ 1437]: inotify_inode_queue_event <-sys_read
