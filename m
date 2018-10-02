From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Tue, 2 Oct 2018 16:28:44 -0700
Message-ID: <c0a5b479-72d7-8b03-09ce-31e0a4cd09ba@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
 <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1810030758460.23596@namei.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/02/2018 03:06 PM, James Morris wrote:
> On Tue, 2 Oct 2018, Kees Cook wrote:
> 
>> On Tue, Oct 2, 2018 at 11:57 AM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>> Under the current scheme
>>>
>>> lsm.enabled=selinux
>>>
>>> could actually mean selinux,yama,loadpin,something_else are
>>> enabled. If we extend this behavior to when full stacking lands
>>>
>>> lsm.enabled=selinux,yama
>>>
>>> might mean selinux,yama,apparmor,loadpin,something_else
>>>
>>> and what that list is will vary from kernel to kernel, which I think
>>> is harder for the user than the lsm.enabled list being what is
>>> actually enabled at boot
>>
>> Ah, I think I missed this in your earlier emails. What you don't like
>> here is that "lsm.enable=" is additive. You want it to be explicit.
>>
> 
> This is a path to madness.
> 
> How about enable flags set ONLY per LSM:
> 
> lsm.selinux.enable=x
> lsm.apparmor.enable=x
> 
why add the lsm. prefix? I think if we go this route
selinux.enable=x
apparmor.enable=x

is a little cleaner

the question then becomes is this easier for users? Doing something
similar to this was discussed earlier but its more tedious to type
each of these out, and since they are separate options they can
get spread out making it easy to miss one when you are changing
your boot options.

I honestly don't think we are going to come to a consensus on what is
best for users because different sets of users have different priorities.
But I do think we need to come up with something cleaner than v3

> With no lsm.enable, and removing selinux=x and apparmor=x.
>
this will break the user api, not just the distro/builder kernel
config. I do think it is probably worth doing, but not everyone agrees.

> Yes this will break existing docs, but they can be updated for newer 
> kernel versions to say "replace selinux=0 with lsm.selinux.enable=0" from 
> kernel X onwards.
> 
yes docs can be updated but it does take time to propagate out and their
are always the dozens of blog, and forum posts etc that google will
drag up that won't get updated

> Surely distro packages and bootloaders are able to cope with changes to 
> kernel parameters?
> 
yes, but users who have been taught to add certain incantations to their
kernel parameters find it a lot harder

> We can either take a one-time hit now, or build new usability debt, which 
> will confuse people forever.
> 

I'm not opposed to taking a one-time hit for usability in the future.
