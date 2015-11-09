From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Mon, 9 Nov 2015 18:35:48 +0200
Message-ID: <CAE1zotLvd3wpym0jnQhi7cBRPu3wsVxg7reBqXY8SnqS8Mp+-Q@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
	<20151103224545.GI29330@redhat.com>
	<CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
	<20151104135015.GN29330@redhat.com>
	<CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
	<563D4758.9080507@nod.at>
	<20151107104806.GV29330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151107104806.GV29330@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Nov 7, 2015 at 12:48 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> I just pushed a (very early) WIP branch that contains changes to
> libguestfs to add an LKL backend:
>
>   https://github.com/rwmjones/libguestfs/tree/lkl
>
> Read the README file in the libguestfs sources before starting,
> followed by the instructions in the commit message:
>
>   https://github.com/rwmjones/libguestfs/commit/e38525f0b984d0a426f3348d95f2033673d4eaa4
>

Hi Richard,

Thanks for this, I was able to replicate it locally.

I started working on adding a new library, liblkl-redirect.a, that
redefines common libc symbols to use lkl. We then can link the daemon
with this lib and lkl to avoid ugly ifdefs in the daemon code.

Thanks,
Tavi
