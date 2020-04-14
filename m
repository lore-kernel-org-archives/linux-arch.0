Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 14 Apr 2020 06:02:03 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414130203.GA20867@infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200414072316.GA5503@infradead.org>
 <1586864403.0qfilei2ft.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586864403.0qfilei2ft.astroid@bobo.none>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414130203.lym_oYhZrW1bldtxPW5nVb6bah3MSQT6NhRJIv5FiuU@z>

On Tue, Apr 14, 2020 at 10:13:44PM +1000, Nicholas Piggin wrote:
> Which case? Usually the answer would be because you don't want to use
> contiguous physical memory and/or you don't want to use the linear 
> mapping.

But with huge pages you do by definition already use large contiguous
areas.  So you want allocations larger than "small" huge pages but not
using gigantic pages using vmalloc?
