From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
Date: Tue, 2 Oct 2018 15:19:57 +0200
Message-ID: <CAAeHK+xK2Nb6J6YbvUJdXaZoecB0GS2UyY6pgGwrfCoOQJ34xg@mail.gmail.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
 <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
 <CA+55aFzQ+ykLu10q3AdyaaKJx8SDWWL9Qiu6WH2jbN_ugRUTOg@mail.gmail.com>
 <20180911164152.GA29166@arrakis.emea.arm.com> <CAAeHK+z4HOF_PobxSys8svftWt8dhbuUXEpq2sdXBTCXwTEH2g@mail.gmail.com>
 <20180928175013.GC193149@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928175013.GC193149@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.or>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 7:50 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Sep 17, 2018 at 07:01:00PM +0200, Andrey Konovalov wrote:

>> Looking at patch #8 ("usb, arm64: untag user addresses in devio") in
>> this series, it seems that that devio ioctl actually accepts a pointer
>> into a vma, so we shouldn't actually be untagging its argument and the
>> patch needs to be dropped.
>
> You are right, the pointer seems to have originated from the kernel as
> already untagged (mmap() on the driver), so we would expect the user to
> pass it back an untagged pointer.

OK, dropped this patch in v7.

>> As for case 1, the places where pointers are compared with TASK_SIZE
>> and others can be found with grep. Maybe it makes sense to introduce
>> some kind of routine like is_user_pointer() that handles tagged
>> pointers and refactor the existing code to use it? And maybe add a
>> rule to checkpatch.pl that forbids the direct usage of TASK_SIZE and
>> others.
>>
>> So I think detecting direct comparisons with TASK_SIZE and others
>> would more useful than finding __user pointer casts (it seems that the
>> latter requires a lot of annotations to be fixed/added), and I should
>> just drop this patch with annotations.
>
> I think point (1) is not too bad, usually found with grep.
>
> As I've said in my previous reply, I kind of came to the same conclusion
> that searching __user pointer casts to long may not actually scale. If
> we could add an __untagged annotation to ulong where it matters (e.g.
> find_vma()), we could identify a ulong (default tagged) and annotate
> some of those.
>
> However, this analysis on __user * casting was useful even if we don't
> end up using it. If we come up with a clearer definition of the ABI
> (which syscalls accept tagged pointers), we may conclude that the only
> places where untagging matters are a few find_vma() calls in the arch
> and mm code and can ignore the rest.

So what exactly should I do now?

For now I've posted v7 with the sparse annotation patch dropped (to
have the most up-do-date version posted).
