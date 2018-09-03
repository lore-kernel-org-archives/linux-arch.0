From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
Date: Mon, 3 Sep 2018 14:34:27 +0200
Message-ID: <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local> <20180831134244.GB19965@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831134244.GB19965@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 31, 2018 at 3:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
>> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
>> > This patch adds __force annotations for __user pointers casts detected by
>> > sparse with the -Wcast-from-as flag enabled (added in [1]).
>> >
>> > [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
>>
>> Hi,
>>
>> It would be nice to have some explanation for why these added __force
>> are useful.

I'll add this in the next version, thanks!

>         It would be even more useful if that series would either deal with
> the noise for real ("that's what we intend here, that's what we intend there,
> here's a primitive for such-and-such kind of cases, here we actually
> ought to pass __user pointer instead of unsigned long", etc.) or left it
> unmasked.
>
>         As it is, __force says only one thing: "I know the code is doing
> the right thing here".  That belongs in primitives, and I do *not* mean the
> #define cast_to_ulong(x) ((__force unsigned long)(x))
> kind.
>
>         Folks, if you don't want to deal with that - leave the warnings be.
> They do carry more information than "someone has slapped __force in that place".
>
> Al, very annoyed by that kind of information-hiding crap...

This patch only adds __force to hide the reports I've looked at and
decided that the code does the right thing. The cases where this is
not the case are handled by the previous patches in the patchset. I'll
this to the patch description as well. Is that OK?
