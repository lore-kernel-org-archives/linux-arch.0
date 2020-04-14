From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Wed, 15 Apr 2020 00:48:13 +1000
Message-ID: <1586875675.f8q1grbltc.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200414072316.GA5503@infradead.org>
        <1586864403.0qfilei2ft.astroid@bobo.none>
        <20200414130203.GA20867@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404893AbgDNOsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 10:48:19 -0400
In-Reply-To: <20200414130203.GA20867@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org

Excerpts from Christoph Hellwig's message of April 14, 2020 11:02 pm:
> On Tue, Apr 14, 2020 at 10:13:44PM +1000, Nicholas Piggin wrote:
>> Which case? Usually the answer would be because you don't want to use
>> contiguous physical memory and/or you don't want to use the linear=20
>> mapping.
>=20
> But with huge pages you do by definition already use large contiguous
> areas.  So you want allocations larger than "small" huge pages but not
> using gigantic pages using vmalloc?

Yes.

Thanks,
Nick
