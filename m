From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
Date: Mon, 24 Nov 2014 14:58:08 -0800
Message-ID: <CAADnVQ+8d0GC5OwQTdJKkmG8=vshUVqK1pPou1GCGa_iuU2v-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 24, 2014 at 12:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 24, 2014 at 12:04 PM, David Howells <dhowells@redhat.com> wrote:
>>
>> Reserve ACCESS_ONCE() for reading and add an ASSIGN_ONCE() or something like
>> that for writing?
>
> I wouldn't mind that. We've had situations where reading and writing
> isn't really similar - like alpha where reading a byte is atomic, but
> writing one isn't.
>
> Then we could also make it have the "get_user()/put_user()" kind of
> semantics - .and then use the same "sizeopf()" tricks that we use for
> get_user/put_user.
>
> That would actually work around the gcc bug a completely different way:
>
>   #define ACCESS_ONCE(p) \
>       ({ typeof(*p) __val; __read_once_size(p, &__val, sizeof(__val)); __val; })
>
> and then we can do things like this:
>
>   static __always_inline void __read_once_size(volatile void *p, void
> *res, int size)
>   {
>        switch (size) {
>        case 1: *(u8 *)res = *(volatile u8 *)p; break;
>        case 2: *(u16 *)res = *(volatile u16 *)p; break;
>        case 4: *(u32 *)res = *(volatile u32 *)p; break;
> #ifdef CONFIG_64BIT
>        case 8: *(u64 *)res = *(volatile u64 *)p; break;
> #endif
>        }
>   }
>
> and same for ASSIGN_ONCE(val, p).
>
> That also hopefully avoids the whole "oops, gcc has a bug", because
> the actual volatile access is always done using a scalar type, even if
> the type of "__val" may in fact be a structure.

I've changed gcc pr58145-1.c reproducer to use
__read_once_size() approach above, but it
didn't help to workaround the bug.
gcc 'sra' pass still lost 'volatile' modifier.

modified reproducer:
struct S { unsigned int data; };
void bar(int val)
{
  struct S _s = { .data = val };
  *(volatile struct S *) 0x880000UL = ACCESS_ONCE(&_s);
}
assembler code looks as expected, but
internal gcc state after 'sra' pass is
missing volatile...
