From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Tue, 03 Apr 2018 15:29:40 -0700 (PDT)
Message-ID: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
References: <CAK8P3a0+Q-aBbKsqqypZfCVzHTwcepL9KhBP9qJKE+2FknWHMg@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0+Q-aBbKsqqypZfCVzHTwcepL9KhBP9qJKE+2FknWHMg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 03 Apr 2018 05:56:18 PDT (-0700), Arnd Bergmann wrote:
> On Tue, Apr 3, 2018 at 2:44 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/3/2018 7:13 AM, Arnd Bergmann wrote:
>>> On Tue, Apr 3, 2018 at 12:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> Hi,
>>>>
>>>> On Fri, Mar 30, 2018 at 11:58:13AM -0400, Sinan Kaya wrote:
>>>>> The default implementation of mapping readX() to __raw_readX() is wrong.
>>>>> readX() has stronger ordering semantics. Compiler is allowed to reorder
>>>>> __raw_readX().
>>>>
>>>> Could you please specify what the compiler is potentially reordering
>>>> __raw_readX() against, and why this would be wrong?
>>>>
>>>> e.g. do we care about prior normal memory accesses, subsequent normal
>>>> memory accesses, and/or other IO accesses?
>>>>
>>>> I assume that the asm-generic __raw_{read,write}X() implementations are
>>>> all ordered w.r.t. each other (at least for a specific device).
>>>
>>> I think that is correct: the compiler won't reorder those because of the
>>> 'volatile' pointer dereference, but it can reorder access to a normal
>>> pointer against a __raw_readl()/__raw_writel(), which breaks the scenario
>>> of using writel to trigger a DMA, or using a readl to see if a DMA has
>>> completed.
>>
>> Yes, we are worried about memory update vs. IO update ordering here.
>> That was the reason why barrier() was introduced in this patch. I'll try to
>> clarify that better in the commit text.
>>
>>>
>>> The question is whether we should use a stronger barrier such
>>> as rmb() amd wmb() here rather than a simple compiler barrier.
>>>
>>> I would assume that on complex architectures with write buffers and
>>> out-of-order prefetching, those are required, while on architectures
>>> without those features, the barriers are cheap.
>>
>> That's my reasoning too. I'm trying to follow the x86 example here where there
>> is a compiler barrier in writeX() and readX() family of functions.
>
> I think x86 is the special case here because it implicitly guarantees
> the strict ordering in the hardware, as long as the compiler gets it
> right. For the asm-generic version, it may be better to play safe and
> do the safest version, requiring architectures to override that barrier
> if they want to be faster.
>
> We could use the same macros that riscv has, using __io_br(),
> __io_ar(), __io_bw() and __io_aw() for before/after read/write.

FWIW, when I wrote this I wasn't sure what the RISC-V memory model was going to 
be so I just picked something generic.  In other words, it's already a generic 
interface, just one that we're the only users of :).
