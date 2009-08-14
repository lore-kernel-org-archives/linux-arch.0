From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 09:04:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
References: <20090812183934.777715527@de.ibm.com> <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain> <20090814123439.GB4959@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55241 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932580AbZHNQKn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 12:10:43 -0400
In-Reply-To: <20090814123439.GB4959@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>



On Fri, 14 Aug 2009, Heiko Carstens wrote:
> 
> All of this started when we compared a 2.6.27 based distro kernel
> to a 2.6.16 based one. It turned out that 2.6.27 burns a lot more cpu
> cycles than 2.6.16 does for the same workloads.
> 
> As an example: we took a simple one connection ping pong network load.
> (client sends packet to server and waits until packet from server
>  returns and game starts again). It uses more cpu cycles on 2.6.27.
> 
> Using ftrace we figured out that on 2.6.27 it takes more than 500 function
> calls on the client for a single roundtrip while on 2.6.16 it took only
> ~230 calls.

Hmm. But the spinlock part of this seems to not really have changed.

Removing everything but the actual callchain info, and then doing a "diff" 
between your two roundtrips, and they look very different, and basically 
none of the difference seems to be due to spinlocks.

It seems to be due to a number of different things, but the bulk of the 
new costs seem to be in networking (and to some degree scheduling). There 
are smaller differences elsewhere, but the networking code _really_ blows 
up.

I don't know how much of some of these are "real" kernel changes, and how 
much of it is less inlining, but spinlocks don't seem to be the issue. 
Here's a quick walk-through (some of these get repeated a couple of times 
in your traces)

 * Apparmor going through the generic security code and rw_verify_area:

	apparmor_file_permission <-sys_write

   becomes

	security_file_permission <-rw_verify_area
	apparmor_file_permission <-security_file_permission
	aa_file_permission <-apparmor_file_permission

 * the vfs write itself being deeper

	sock_aio_write <-sys_write

   becomes

	vfs_write <-SyS_write
	rw_verify_area <-vfs_write
	do_sync_write <-vfs_write
	sock_aio_write <-do_sync_write

 * the socket code does totally new apparmor security things that were not 
   in 2.6.16 at all:

	security_socket_sendmsg <-sock_aio_write
	apparmor_socket_sendmsg <-security_socket_sendmsg
	aa_revalidate_sk <-apparmor_socket_sendmsg

 * TCP doing more:

	__alloc_skb <-tcp_sendmsg
	..
	..
	ip_output <-ip_queue_xmit
	dev_queue_xmit <-ip_output

   becomes

	tcp_established_options <-tcp_current_mss
	sk_stream_alloc_skb <-tcp_sendmsg
	__alloc_skb <-sk_stream_alloc_skb
	..
	tcp_init_tso_segs <-__tcp_push_pending_frames
	tcp_set_skb_tso_segs <-tcp_init_tso_segs
	..
	__skb_clone <-skb_clone
	__copy_skb_header <-__skb_clone
	tcp_established_options <-tcp_transmit_skb
	skb_push <-tcp_transmit_skb
	__tcp_select_window <-tcp_transmit_skb
	tcp_options_write <-tcp_transmit_skb
	..
	__sk_dst_check <-ip_queue_xmit
	skb_push <-ip_queue_xmit
	ip_local_out <-ip_queue_xmit
	__ip_local_out <-ip_local_out
	ip_output <-ip_local_out
	ip_finish_output <-ip_output
	skb_push <-ip_finish_output
	dev_queue_xmit <-ip_finish_output
	local_bh_disable <-dev_queue_xmit

 * More TCP changes at tcp_ack time:

	kfree <-__kfree_skb
	kmem_cache_free <-__kfree_skb
	tcp_reno_cong_avoid <-tcp_ack
	tcp_current_mss <-tcp_rcv_established
	__tcp_push_pending_frames <-tcp_rcv_established
	tcp_send_delayed_ack <-tcp_rcv_established

   becomes

	skb_release_all <-__kfree_skb
	dst_release <-skb_release_all
	skb_release_data <-skb_release_all
	kfree <-skb_release_data
	kmem_cache_free <-__kfree_skb
	tcp_rtt_estimator <-tcp_ack
	bictcp_acked <-tcp_ack
	bictcp_cong_avoid <-tcp_ack
	tcp_is_cwnd_limited <-bictcp_cong_avoid
	tcp_current_mss <-tcp_rcv_established
	tcp_established_options <-tcp_current_mss
	__tcp_push_pending_frames <-tcp_rcv_established
	__tcp_ack_snd_check <-tcp_rcv_established
	tcp_send_delayed_ack <-__tcp_ack_snd_check

 * The network driver doing more:

	qeth_hard_start_xmit <-dev_hard_start_xmit
	qeth_fill_header <-qeth_hard_start_xmit
	memset <-qeth_fill_header
	memset <-qeth_fill_header
	skb_queue_tail <-qeth_hard_start_xmit
	..
	mod_timer <-do_QDIO
	_spin_lock_irqsave <-mod_timer
	_spin_unlock_irqrestore <-mod_timer
	raise_softirq_irqoff <-qeth_hard_start_xmit
	..

   becomes

	qeth_l3_hard_start_xmit <-dev_hard_start_xmit
	qeth_get_cast_type <-qeth_l3_hard_start_xmit
	qeth_get_priority_queue <-qeth_l3_hard_start_xmit
	skb_realloc_headroom <-qeth_l3_hard_start_xmit
	pskb_copy <-skb_realloc_headroom
	__alloc_skb <-pskb_copy
	kmem_cache_alloc <-__alloc_skb
	__kmalloc <-__alloc_skb
	skb_put <-pskb_copy
	copy_skb_header <-pskb_copy
	__copy_skb_header <-copy_skb_header
	skb_pull <-qeth_l3_hard_start_xmit
	skb_push <-qeth_l3_hard_start_xmit
	qeth_l3_fill_header <-qeth_l3_hard_start_xmit
	qeth_get_elements_no <-qeth_l3_hard_start_xmit
	qeth_do_send_packet <-qeth_l3_hard_start_xmit
	skb_queue_tail <-qeth_do_send_packet
	..
	qdio_perf_stat_inc <-do_QDIO
	qdio_kick_outbound_q <-do_QDIO
	qdio_perf_stat_inc <-qdio_kick_outbound_q
	__tasklet_schedule <-do_QDIO
	dev_kfree_skb_any <-qeth_l3_hard_start_xmit
	kfree_skb <-dev_kfree_skb_any
	__kfree_skb <-kfree_skb
	skb_release_all <-__kfree_skb
	dst_release <-skb_release_all
	sock_wfree <-skb_release_all
	skb_release_data <-skb_release_all
	__netif_schedule <-qeth_l3_hard_start_xmit
	raise_softirq_irqoff <-__netif_schedule
	..
	tasklet_action <-__do_softirq
	qdio_outbound_processing <-tasklet_action
	qdio_perf_stat_inc <-qdio_outbound_processing
	mod_timer <-qdio_outbound_processing

 * the timer code doing more:

	__timer_stats_timer_set_start_info <-mod_timer
	__mod_timer <-mod_timer
	__timer_stats_timer_set_start_info <-__mod_timer
	lock_timer_base <-__mod_timer
	_spin_lock_irqsave <-lock_timer_base
	internal_add_timer <-__mod_timer
	_spin_unlock_irqrestore <-__mod_timer
	qdio_perf_stat_inc <-qdio_outbound_processing
	account_system_vtime <-__do_softirq

 * the scheduler code doing way deeper chains:

	profile_hit <-schedule
	sched_clock <-schedule
	_spin_lock_irq <-schedule
	account_vtime <-schedule
	account_user_time <-account_vtime

   becomes

	_spin_lock <-schedule
	sched_clock_cpu <-schedule
	sched_clock <-sched_clock_cpu
	deactivate_task <-schedule
	dequeue_task <-deactivate_task
	dequeue_task_fair <-dequeue_task
	dequeue_entity <-dequeue_task_fair
	update_curr <-dequeue_entity
	hrtick_start_fair <-dequeue_task_fair
	put_prev_task_fair <-schedule
	pick_next_task_fair <-schedule
	pick_next_task_rt <-schedule
	pick_next_task_fair <-schedule
	pick_next_task_idle <-schedule
	_spin_trylock <-tracing_record_cmdline
	finish_task_switch <-schedule
	account_vtime <-finish_task_switch
	account_user_time <-account_vtime
	acct_update_integrals <-account_user_time
	jiffies_to_timeval <-acct_update_integrals

Hmm. Not pretty.

		Linus
