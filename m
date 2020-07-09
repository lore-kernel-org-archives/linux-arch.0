From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v19 08/12] landlock: Add syscall implementation
Date: Thu, 9 Jul 2020 19:26:18 +0200
Message-ID: <CAK8P3a34X1qfDhn8u3nR+aQA_g+V2i35L0oTnvhNAs83YJPB_w@mail.gmail.com>
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-9-mic@digikod.net>
 <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
 <7f407b67-d470-25fd-1287-f4f55f18e74a@digikod.net> <CAK8P3a1ehWZErD2a0iBqn37s-LTAtW0AbV_gt32iX3cQkXbpOQ@mail.gmail.com>
 <ec79f6ad-1c11-d69f-724b-622baa28f19f@digikod.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ec79f6ad-1c11-d69f-724b-622baa28f19f-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Anton Ivanov <anton.ivanov-eaSgp5hN2EAtwqFdIEgyzdBPR1lH4CV8@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jeff Dike <jdike-OPE4K8JWMJJBDgjK7y7TUQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, Kernel Hardening <kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-a
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 8, 2020 at 7:50 PM Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> wrote:
> On 08/07/2020 15:49, Arnd Bergmann wrote:
> > On Wed, Jul 8, 2020 at 3:04 PM Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> wrote:
> >> On 08/07/2020 10:57, Arnd Bergmann wrote:
> >>> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> wrote:
> >>>
> >>> It looks like all you need here today is a single argument bit, plus
> >>> possibly some room for extensibility. I would suggest removing all
> >>> the extra bits and using a syscall like
> >>>
> >>> SYSCALL_DEFINE1(landlock_create_ruleset, u32, flags);
> >>>
> >>> I don't really see how this needs any variable-length arguments,
> >>> it really doesn't do much.
> >>
> >> We need the attr_ptr/attr_size pattern because the number of ruleset
> >> properties will increase (e.g. network access mask).
> >
> > But how many bits do you think you will *actually* need in total that
> > this needs to be a two-dimensional set of flags? At the moment you
> > only have a single bit that you interpret.
>
> I think there is a misunderstanding. For this syscall I wasn't talking
> about the "options" field but about the "handled_access_fs" field which
> has 14 bits dedicated to control access to the file system:
> https://landlock.io/linux-doc/landlock-v19/security/landlock/user.html#filesystem-flags

Ok, got it. I didn't read far enough there.

> The idea is to add other handled_access_* fields for other kernel object
> types (e.g. network, process, etc.).
>
> The "options" field is fine as a raw __u32 syscall argument.

I'd still like to avoid having it variable-length and structured though.
How about having a __u32 "options" flag, plus an indirect argument
with 32 fixed-length (all 32 bit or all 64 bit) flag words, each of which
corresponds to one of the option bits?

It's still fairly complex that way, but not as much as the version
you have right now that can be extended in multiple dimensions.

This could possibly also help avoid the need for the get_features
syscall: If user space just passes the bitmap of all the access flags
it wants to use in a fixed-size structure, the kernel can update the
bits to mask out the ones it does not understand and write back
that bitmap as the result of create_ruleset().

> >>> To be on the safe side, you might split up the flags into either the
> >>> upper/lower 16 bits or two u32 arguments, to allow both compatible
> >>> (ignored by older kernels if flag is set) and incompatible (return error
> >>> when an unknown flag is set) bits.
> >>
> >> This may be a good idea in general, but in the case of Landlock, because
> >> this kind of (discretionary) sandboxing should be a best-effort security
> >> feature, we should avoid incompatible behavior. In practice, every
> >> unknown bit returns an error because userland can probe for available
> >> bits thanks to the get_features command. This kind of (in)compatibility
> >> can then be handled by userland.
> >
> > If there are not going to be incompatible extensions, then just ignore
> > all unknown bits and never return an error but get rid of the user
> > space probing that just complicates the interface.
>
> There was multiple discussions about ABI compatibility, especially
> inspired by open(2) vs. openat2(2), and ignoring flags seems to be a bad
> idea. In the "sandboxer" example, we first probe the supported features
> and then mask unknown bits (i.e. access rights) at run time in userland.
> This strategy is quite straightforward, backward compatible and
> future-proof.

For behavior changing flags, I agree they should be seen as
incompatible flags (i.e. return an error if an unknown bit is set).

However, for the flags you pass in in an allowlist, treating them
as compatible (i.e. ignore any unknown flags, allowing everything
you are not forbidding already) seems completely reasonable
to me. Do you foresee user space doing anything other than masking
out the bits that the kernel doesn't know about? If not, then doing
it in the  kernel should always be simpler.

> >> I suggest this syscall signature:
> >> SYSCALL_DEFINE3(landlock_create_ruleset, __u32, options, const struct
> >> landlock_attr_ruleset __user *, ruleset_ptr, size_t, ruleset_size);
> >
> > The other problem here is that indirect variable-size structured arguments
> > are a pain to instrument with things like strace or seccomp, so you
> > should first try to use a fixed argument list, and fall back to a fixed
> > structure if that fails.
>
> I agree that it is not perfect with the current tools but this kind of
> extensible structs are becoming common and well defined (e.g. openat2).
> Moreover there is some work going on for seccomp to support "extensible
> argument" syscalls: https://lwn.net/Articles/822256/

openat2() is already more complex than we'd ideally want, I think we
should try hard to make new syscalls simpler than that, following the
rule that any interface should be as simple as possible, but no simpler.

> >>>> +static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
> >>>> +               const size_t attr_size)
> >>>> +{
> >>>> +       struct landlock_attr_path_beneath attr_path_beneath;
> >>>> +       struct path path;
> >>>> +       struct landlock_ruleset *ruleset;
> >>>> +       int err;
> >>>
> >>> Similarly, it looks like this wants to be
> >>>
> >>> SYSCALL_DEFINE3(landlock_add_rule_path_beneath, int, ruleset, int,
> >>> path, __u32, flags)
> >>>
> >>> I don't see any need to extend this in a way that wouldn't already
> >>> be served better by adding another system call. You might argue
> >>> that 'flags' and 'allowed_access' could be separate, with the latter
> >>> being an indirect in/out argument here, like
> >>>
> >>> SYSCALL_DEFINE4(landlock_add_rule_path_beneath, int, ruleset, int, path,
> >>>                            __u64 *, allowed_acces, __u32, flags)
> >>
> >> To avoid adding a new syscall for each new rule type (e.g. path_beneath,
> >> path_range, net_ipv4_range, etc.), I think it would be better to keep
> >> the attr_ptr/attr_size pattern and to explicitely set a dedicated option
> >> flag to specify the attr type.
> >>
> >> This would look like this:
> >> SYSCALL_DEFINE4(landlock_add_rule, __u32, options, int, ruleset, const
> >> void __user *, rule_ptr, size_t, rule_size);
> >>
> >> The rule_ptr could then point to multiple types like struct
> >> landlock_attr_path_beneath (without the current ruleset_fd field).
> >
> > This again introduces variable-sized structured data. How many different
> > kinds of rule types do you think there will be (most likely, and maybe an
> > upper bound)?
>
> I don't know how many rule types will come, but right now I think it may
> be less than 10.

Ok,

> > Could (some of) these be generalized to use the same data structure?
>
> I don't think so, file path and network addresses are an example of very
> different types.

Clearly the target object is something different, but maybe there is
enough commonality to still make them fit into a more regular form.

For the file system case, you have an identify for an object
(the file descriptor) and the  '__u64 allowed_access'. I would
expect that the 'allowed_access' concept is generic enough that
you can make it a direct argument (32 bit register arg, or pointer
to a __u64). Do you expect others to need something besides
an object identifier and a permission bitmask? Maybe it could
be something like

 SYSCALL_DEFINE4(landlock_add_rule, int, ruleset, __u32, options,
                       const void __user *, object, const __u64 __user
*, allowed_access,
                       __u32, flags);

with a fixed-length 'object' identifier type (file descriptor,
sockaddr_storage, ...) for each option.

    Arnd
