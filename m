From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/8] Update kernel uabi header files for x32
Date: Mon, 20 Jan 2014 09:52:03 -0800
Message-ID: <52DD6243.1000205@zytor.com>
References: <1388182464-28428-1-git-send-email-hjl.tools@gmail.com> <20131228163308.GA1638@infradead.org> <52DD6101.4010708@zytor.com> <20140120175033.GA11534@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140120175033.GA11534@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On 01/20/2014 09:50 AM, Christoph Hellwig wrote:
> On Mon, Jan 20, 2014 at 09:46:41AM -0800, H. Peter Anvin wrote:
>> This comment by Christoph was literally the only feedback on this
>> patchset.  The definition of __kernel_[u]long_t is "the size of 'long'
>> for the native kernel for the ABI".  H.J.'s patchset only affects x86
>> (specifically x86-64) since on all other platforms __kernel_[u]long_t is
>> simply defined as long/unsigned long.
> 
> Btw, sorry for the delay in getting back yo your question.  How about
> __abi_long_t or __kabi_long_t instead?
> 

__kernel_* is the namespace that we reserve for uabi symbols/types in
user space.  Changing the prefix would break that contract.

	-hpa
