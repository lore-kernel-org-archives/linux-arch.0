Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266364AbUHIJBk@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:11444 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266359AbUHIJBk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 05:01:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16663.15729.828367.307053@napali.hpl.hp.com>
Date: Mon, 9 Aug 2004 02:01:37 -0700
Subject: Re: copy_page_range()
In-Reply-To: <20040807000529.5ca6e8fe.davem@redhat.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
Reply-To: davidm@hpl.hp.com
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Sat, 7 Aug 2004 00:05:29 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> Every couple months I look at this thing.

  DaveM> The main issue is that it's very cache unfriendly, especially
  DaveM> with how sparsely populated the page tables are for 64-bit
  DaveM> processes.

  DaveM> As a simple example, it's at the top of the kernel profile
  DaveM> for 64-bit lat_proc {fork,exec,shell} on sparc64.

I didn't recall copy_page_range() being so high on ia64, but it's been
a while since looked at this, so I ran it again (this is with a simple
fork() loop; lmbench is trying to be too clever for me so I don't like
profiling it...):

% time      self     cumul     calls self/call  tot/call name
 36.89     10.78     10.78      267k     40.4u     40.4u clear_page_tables
 25.99      7.59     18.37      573k     13.2u     13.2u copy_page
 11.42      3.34     21.70     2.07M     1.61u     1.61u clear_page
  2.26      0.66     22.36     1.71M      385n      428n copy_page_range
  1.64      0.48     22.84      546k      878n      898n finish_task_switch
  1.50      0.44     23.28      314k     1.39u     1.48u unmap_vmas
  1.37      0.40     23.68     4.07M     98.2n     98.2n __copy_user
  1.32      0.39     24.06      302k     1.27u     1.38u release_task
  1.19      0.35     24.41     5.73M     60.6n     60.6n page_remove_rmap
  1.17      0.34     24.75     2.98M      114n      126n buffered_rmqueue
  1.01      0.30     25.05      316k      933n     6.37u copy_process
  0.92      0.27     25.32     2.68M      101n      107n free_hot_cold_page
  0.67      0.20     25.51     6.02M     32.7n     32.7n put_page

I suspect some reasons for the different profile may be:

 - 16KB page-size vs. 4KB page-size
 - My binary was statically linked

The good news is that your proposal should help clear_page_tables()
just as easily as copy_page_range(). ;-)

	--david
