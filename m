From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [guv v2 23/31] tile: Replace __get_cpu_var uses
Date: Fri, 30 Aug 2013 12:01:15 -0400
Message-ID: <5220C1CB.7050007@tilera.com>
References: <20130826204351.725357339@linux.com> <00000140bc69acdb-3b2967b0-e224-424b-ad08-973515704be6-000000@email.amazonses.com> <521BD523.3040706@tilera.com> <00000140c03f13d6-07480caf-b5b0-440b-af95-04878ee9f46c-000000@email.amazonses.com> <521E312C.2050004@tilera.com> <00000140c60fe2a0-aff878d7-06b3-4fe8-b97f-b319183f3f52-000000@email.amazonses.com> <521E3DD5.6020409@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:29355 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab3H3QBR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 12:01:17 -0400
In-Reply-To: <521E3DD5.6020409@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

On 8/28/2013 2:13 PM, Chris Metcalf wrote:
> On 8/28/2013 1:54 PM, Christoph Lameter wrote:
>> On Wed, 28 Aug 2013, Chris Metcalf wrote:
>>> In addition, I applied the following commit to clean up the remaining
>>> uses that are currently only being carried in the linux-tile tree.
>> You are going to merge these changes right? I can drop the tile patch from
>> my series?
> Yes, I am, so please feel free to drop it.

Given the nacks from Peter Ziljstra and Ingo Molnar, I'm changing my mind and dropping this patch from my tree, so please continue to include arch/tile in your tree as you figure out how you want to restructure the overall series.

I reviewed the one commit in the linux-tile tree that added new __get_cpu_var uses (kprobes support), and concluded the code can safely use __this_cpu_write etc (and in fact the generic reset_current_kprobe method already does so), so I modified the code not to use __get_cpu_var.  So there shouldn't be any new uses from the tile tree after the merge window opens.

Their concerns feel particularly relevant to arch/tile since one of the commits queued for the merge window is support for preemption :-)

Thanks!

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
