From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
 to user space
Date: Tue, 11 May 2010 17:55:38 +0200
Message-ID: <4BE97DFA.1060408@suse.de>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Cc: avi@redhat.com, mtosatti@redhat.com, yoshikawa.takuya@oss.ntt.co.jp, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Takuya Yoshikawa wrote:
> Hi, sorry for sending from my personal account.
> The following series are all from me:
>
>   From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
>
>   The 3rd version of "moving dirty bitmaps to user space".
>
> From this version, we add x86 and ppc and asm-generic people to CC lists.
>
>
> [To KVM people]
>
> Sorry for being late to reply your comments.
>
> Avi,
>  - I've wrote an answer to your question in patch 5/12: drivers/vhost/vhost.c .
>
>  - I've considered to change the set_bit_user_non_atomic to an inline function,
>    but did not change because the other helpers in the uaccess.h are written as
>    macros. Anyway, I hope that x86 people will give us appropriate suggestions
>    about this.
>
>  - I thought that documenting about making bitmaps 64-bit aligned will be
>    written when we add an API to register user-allocated bitmaps. So probably
>    in the next series.
>
> Avi, Alex,
>  - Could you check the ia64 and ppc parts, please? I tried to keep the logical
>    changes as small as possible.
>
>    I personally tried to build these with cross compilers. For ia64, I could check
>    build success with my patch series. But book3s, even without my patch series,
>    it failed with the following errors:
>
>   arch/powerpc/kvm/book3s_paired_singles.c: In function 'kvmppc_emulate_paired_single':
>   arch/powerpc/kvm/book3s_paired_singles.c:1289: error: the frame size of 2288 bytes is larger than 2048 bytes
>   make[1]: *** [arch/powerpc/kvm/book3s_paired_singles.o] Error 1
>   make: *** [arch/powerpc/kvm] Error 2
>   

This is bad. I haven't encountered that one at all so far, but I guess
my compiler version is different from yours. Sigh.

>
> About changelog: there are two main changes from the 2nd version:
>   1. I changed the treatment of clean slots (see patch 1/12).
>      This was already applied today, thanks!
>   2. I changed the switch API. (see patch 11/12).
>
> To show this API's advantage, I also did a test (see the end of this mail).
>
>
> [To x86 people]
>
> Hi, Thomas, Ingo, Peter,
>
> Please review the patches 4,5/12. Because this is the first experience for
> me to send patches to x86, please tell me if this lacks anything.
>
>
> [To ppc people]
>
> Hi, Benjamin, Paul, Alex,
>
> Please see the patches 6,7/12. I first say sorry for that I've not tested these
> yet. In that sense, these may not be in the quality for precise reviews. But I
> will be happy if you would give me any comments.
>
> Alex, could you help me? Though I have a plan to get PPC box in the future,
> currently I cannot test these.
>   

Could you please point me to a git tree where everything's readily
applied? That would make testing a lot easier.

Alex
