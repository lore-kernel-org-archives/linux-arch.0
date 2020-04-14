Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 15 Apr 2020 00:48:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
References: <20200413125303.423864-1-npiggin@gmail.com>
	<20200413125303.423864-5-npiggin@gmail.com>
	<20200414072316.GA5503@infradead.org>
	<1586864403.0qfilei2ft.astroid@bobo.none>
	<20200414130203.GA20867@infradead.org>
In-Reply-To: <20200414130203.GA20867@infradead.org>
MIME-Version: 1.0
Message-ID: <1586875675.f8q1grbltc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414144813.zIKT0UZewyDNTbKm9b9ii-XkMAraGEPfV9tzlOs6jac@z>

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
