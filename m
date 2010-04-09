From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH 02/13] mm: Revalidate anon_vma in page_lock_anon_vma()
Date: Fri, 9 Apr 2010 17:01:11 +0900
Message-ID: <n2x28c262361004090101ufa54ff03zc9a94c8808841206@mail.gmail.com>
References: <20100409150335.80E3.A69D9226@jp.fujitsu.com>
	 <20100409154730.e9945cbc.kamezawa.hiroyu@jp.fujitsu.com>
	 <20100409160252.80E6.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62572 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab0DIIBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 04:01:13 -0400
In-Reply-To: <20100409160252.80E6.A69D9226@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>

Hi, Kosaki.

On Fri, Apr 9, 2010 at 4:29 PM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:
>> Hmm, I think following.
>>
>> Assume a page is ANON and SwapCache, and it has only one reference.
>> Consider it's read-only mapped and cause do_wp_page().
>> page_mapcount(page) =3D=3D 1 here.
>>
>> =C2=A0 =C2=A0 CPU0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU1
>>
>> 1. do_wp_page()
>> 2. .....
>> 3. replace anon_vma. =C2=A0 =C2=A0 anon_vma =3D lock_page_anon_vma()
>>
>> So, lock_page_anon_vma() may have lock on wrong anon_vma, here.(mapc=
ount=3D1)
>>
>> 4. modify pte to writable. =C2=A0 =C2=A0 =C2=A0 =C2=A0do something..=
=2E
>>
>> After lock, in CPU1, a pte of estimated address by vma_address(vma, =
page)
>> containes pfn of the page and page_check_address() will success.
>>
>> I'm not sure how this is dangerouns.
>> But it's possible that CPU1 cannot notice there was anon_vma replace=
ment.
>> And modifies pte withoug holding anon vma's lock which the code beli=
eves
>> it's holded.
>
>
> Hehe, page_referenced() already can take unstable VM_LOCKED value. So=
,
> In worst case we make false positive pageout, but it's not disaster.

OFF-TOPIC:

I think you pointed out good thing, too. :)

You mean although application call mlock of any vma, few pages on the v=
ma can
be swapout by race between mlock and reclaim?

Although it's not disaster, apparently it breaks API.
Man page
" mlock() and munlock()
  mlock()  locks pages in the address range starting at addr and
continuing for len bytes. All pages that contain a part of the
specified address range are guaranteed to be resident in RAM when the
call returns  successfully;  the pages are guaranteed to stay in RAM
until later unlocked."

Do you have a plan to solve such problem?

And how about adding simple comment about that race in page_referenced_=
one?
Could you send the patch?




--=20
Kind regards,
Minchan Kim
