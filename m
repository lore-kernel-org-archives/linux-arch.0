From: Richard Weinberger <richard@nod.at>
Subject: Re: Global do_signal() cleanup
Date: Tue, 08 Oct 2013 17:53:11 +0200
Message-ID: <52542A67.9020900@nod.at>
References: <1381231701-4008-1-git-send-email-richard@nod.at> <52540AE2.4060909@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1661 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754417Ab3JHPxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Oct 2013 11:53:30 -0400
In-Reply-To: <52540AE2.4060909@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, vgupta@synopsys.com, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, vapier@gentoo.org, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, yasutake.koichi@jp.panasonic.com, ralf@linux-mips.org, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, lethal@linux-sh.org, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, linux-xtensa@linux-xtensa.org, akpm@linux-foundation.org, oleg@redhat.com, tj@kernel.org

Am 08.10.2013 15:38, schrieb Michal Simek:
> On 10/08/2013 01:27 PM, Richard Weinberger wrote:
>> This patch series moves all remaining archs to the get_signal() and
>> signal_setup_done() functions. Currently these archs use open coded
>> variants of the said functions.  Further, unused parameters get removed
>> from get_signal_to_deliver(), tracehook_signal_handler() and signal_delivered().
>> After all we save around 350 lines of code. :-)
>>
>> The following archs are _untested_: arc, c6x, hexagon, metag, score, unicore, sh64.
>> If someone points me to cross compilers for these arch I'll happily build test them too.
> 
> Any link to the repo and branch with all these patches will be helpful.

Pushed it into:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git signal_v1

Thanks,
//richard
