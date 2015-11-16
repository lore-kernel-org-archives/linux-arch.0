From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: using IS_ENABLED(CONFIG_xyz) effectively
Date: Mon, 16 Nov 2015 08:35:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44D1969@IN01WEMBXA.internal.synopsys.com>
References: <5613F3DE.4010406@suse.cz>
 <1444165543-2209-1-git-send-email-linux@rasmusvillemoes.dk>
 <56498D0A.3070000@synopsys.com>
 <CAMuHMdVEK041TFY3JJ1kvYE_e_C72+FcRu3ewDipLPi-kN-h=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37214 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbKPIfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 03:35:08 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>

Hi Geert,

On Monday 16 November 2015 01:58 PM, Geert Uytterhoeven wrote:
> Hi Vineet,
>
> On Mon, Nov 16, 2015 at 9:00 AM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> I've been using IS_ENABLED for some time and once in a while run into an issue
>> which prevents seamless use. Hence posing this question to experts in the area.
>>
>> C macro processor evaluates the ensuing control block even if IS_ENABLED evaluates
>> to false. This requires dummy #defines or worse still removing usage of IS_ENABLED
>> altogether.
>>
>> e.g. In example below even for ARCOMPACT builds, we need the ARCV2 specific define
>> ARCV2_IRQ_DEF_PRIO.
>>
>> void arch_cpu_idle(void)
>> {
>>         if (is_isa_arcompact()) {    <---- IS_ENABLED(CONFIG_ISA_ARCOMPACT)
>>                 __asm__("sleep 0x3");
>>         } else {
>>                 const int arg = 0x10 | ARCV2_IRQ_DEF_PRIO;
>>                __asm__("sleep 0x10");
>>         }
>> }
>>
>> One could argue that the interface needs to be cleanly defined to not have such
>> specific #defines in common code in first place. However sometime that becomes
>> just too tedious.
>>
>> Is there a way to get around by this ?
> Use #ifdef CONFIG_...?
>
> The advantage of IS_ENABLED() over #ifdef is that it allows compile-testing of
> the disabled code path. Of course it should only be compiled if it makes
> sense. And that's exactly what you're running into.

And I thought it was to de-uglify the code with same semantics - which doesn't
seem to be the case !
Oh well !

Thx,
-Vineet
