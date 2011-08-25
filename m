From: James Bottomley <James.bottomley@HansenPartnership.com>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Thu, 25 Aug 2011 11:34:34 -0700
Message-ID: <1e295500-5d1f-45dd-aa5b-3d2da2cf1a62@email.android.com>
References: <1313650253-21794-1-git-send-email-gthelen@google.com> <20110818144025.8e122a67.akpm@linux-foundation.org> <1314284272.27911.32.camel@twins> <alpine.DEB.2.00.1108251009120.27407@router.home> <1314289208.3268.4.camel@mulgrave> <alpine.DEB.2.00.1108251128460.27407@router.home> <986ca4ed-6810-426f-b32f-5c8687e3a10b@email.android.com> <alpine.DEB.2.00.1108251206440.27407@router.home>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59137 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab1HYSem (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Aug 2011 14:34:42 -0400
In-Reply-To: <alpine.DEB.2.00.1108251206440.27407@router.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org



Christoph Lameter <cl@linux.com> wrote:

>On Thu, 25 Aug 2011, James Bottomley wrote:
>
>> >ARM seems to have these LDREX/STREX instructions for that purpose
>which
>> >seem to be used for generating atomic instructions without lockes. I
>> >guess
>> >other RISC architectures have similar means of doing it?
>>
>> Arm isn't really risc.  Most don't.  However even with ldrex/strex
>you need two instructions for rmw.
>
>Well then what is "really risc"? RISC is an old beaten down marketing
>term
>AFAICT and ARM claims it too.

Reduced Instruction Set Computer.  This is why we're unlikely to have complex atomic instructions: the principle of risc is that you build them up from basic ones.

James 
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity and top posting.
