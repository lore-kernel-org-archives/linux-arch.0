Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:46273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgGHNuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 09:50:17 -0400
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-9-mic@digikod.net>
 <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com> <7f407b67-d470-25fd-1287-f4f55f18e74a@digikod.net>
In-Reply-To: <7f407b67-d470-25fd-1287-f4f55f18e74a@digikod.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Jul 2020 15:49:57 +0200
Message-ID: <CAK8P3a1ehWZErD2a0iBqn37s-LTAtW0AbV_gt32iX3cQkXbpOQ@mail.gmail.com>
Subject: Re: [PATCH v19 08/12] landlock: Add syscall implementation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>, Richard Weinberger <richard@nod.at>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20200708134957.yE5LaeK5Fev6GwnpKDdo3c4bVBQcxZRSskmE285agH8@z>

On Wed, Jul 8, 2020 at 3:04 PM Mickaël Salaün <mic@digikod.net> wrote:
> On 08/07/2020 10:57, Arnd Bergmann wrote:
> > On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > It looks like all you need here today is a single argument bit, plus
> > possibly some room for extensibility. I would suggest removing all
> > the extra bits and using a syscall like
> >
> > SYSCALL_DEFINE1(landlock_create_ruleset, u32, flags);
> >
> > I don't really see how this needs any variable-length arguments,
> > it really doesn't do much.
>
> We need the attr_ptr/attr_size pattern because the number of ruleset
> properties will increase (e.g. network access mask).

But how many bits do you think you will *actually* need in total that
this needs to be a two-dimensional set of flags? At the moment you
only have a single bit that you interpret.

> > To be on the safe side, you might split up the flags into either the
> > upper/lower 16 bits or two u32 arguments, to allow both compatible
> > (ignored by older kernels if flag is set) and incompatible (return error
> > when an unknown flag is set) bits.
>
> This may be a good idea in general, but in the case of Landlock, because
> this kind of (discretionary) sandboxing should be a best-effort security
> feature, we should avoid incompatible behavior. In practice, every
> unknown bit returns an error because userland can probe for available
> bits thanks to the get_features command. This kind of (in)compatibility
> can then be handled by userland.

If there are not going to be incompatible extensions, then just ignore
all unknown bits and never return an error but get rid of the user
space probing that just complicates the interface.

In general, it's hard to rely on user space to first ask the kernel
what it can do, the way this normally works is that user space
asks the kernel for something and it either does it or not, but gives
an indication of whether it worked.

> I suggest this syscall signature:
> SYSCALL_DEFINE3(landlock_create_ruleset, __u32, options, const struct
> landlock_attr_ruleset __user *, ruleset_ptr, size_t, ruleset_size);

The other problem here is that indirect variable-size structured arguments
are a pain to instrument with things like strace or seccomp, so you
should first try to use a fixed argument list, and fall back to a fixed
structure if that fails.

> >> +static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
> >> +               const size_t attr_size)
> >> +{
> >> +       struct landlock_attr_path_beneath attr_path_beneath;
> >> +       struct path path;
> >> +       struct landlock_ruleset *ruleset;
> >> +       int err;
> >
> > Similarly, it looks like this wants to be
> >
> > SYSCALL_DEFINE3(landlock_add_rule_path_beneath, int, ruleset, int,
> > path, __u32, flags)
> >
> > I don't see any need to extend this in a way that wouldn't already
> > be served better by adding another system call. You might argue
> > that 'flags' and 'allowed_access' could be separate, with the latter
> > being an indirect in/out argument here, like
> >
> > SYSCALL_DEFINE4(landlock_add_rule_path_beneath, int, ruleset, int, path,
> >                            __u64 *, allowed_acces, __u32, flags)
>
> To avoid adding a new syscall for each new rule type (e.g. path_beneath,
> path_range, net_ipv4_range, etc.), I think it would be better to keep
> the attr_ptr/attr_size pattern and to explicitely set a dedicated option
> flag to specify the attr type.
>
> This would look like this:
> SYSCALL_DEFINE4(landlock_add_rule, __u32, options, int, ruleset, const
> void __user *, rule_ptr, size_t, rule_size);
>
> The rule_ptr could then point to multiple types like struct
> landlock_attr_path_beneath (without the current ruleset_fd field).

This again introduces variable-sized structured data. How many different
kinds of rule types do you think there will be (most likely, and maybe an
upper bound)?

Could (some of) these be generalized to use the same data structure?

> >> +static int syscall_enforce_ruleset(const void __user *const attr_ptr,
> >> +               const size_t attr_size)
> >
> > Here it seems like you just need to pass the file descriptor, or maybe
> >
> > SYSCALL_DEFINE2(landlock_enforce, int, ruleset, __u32 flags);
> >
> > if you need flags for extensibility.
>
> Right, but for consistency I prefer to change the arguments like this:
> SYSCALL_DEFINE2(landlock_enforce, __u32 options, int, ruleset);

Most system calls pass the object they work on as the first argument,
in this case this would be the ruleset file descriptor.

     Arnd
