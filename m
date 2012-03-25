From: Kautuk Consul <consul.kautuk@gmail.com>
Subject: Re: [PATCH 08/20 v2] m68k/mm/fault.c: Port OOM changes to do_page_fault
Date: Sun, 25 Mar 2012 06:15:43 -0400
Message-ID: <CAFPAmTTYTfBB-PZ7t0fUNp-56bFa0AZyLpSx=KwdyaQ6hUx9BA@mail.gmail.com>
References: <1332259546-2037-1-git-send-email-consul.kautuk@gmail.com>
	<CAFPAmTTWtZGprAxfAd_k17Bip-cwpamLjAaQWRGfxgv+dwzK8w@mail.gmail.com>
	<CAMuHMdVdhKANw2T0wQd_BXpWXWyUt-ozKoEP5GPH1zaQi6Y-dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVdhKANw2T0wQd_BXpWXWyUt-ozKoEP5GPH1zaQi6Y-dg@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 25, 2012 at 5:13 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Kautuk,
>
> On Sun, Mar 25, 2012 at 10:44, Kautuk Consul <consul.kautuk@gmail.com=
> wrote:
>> did you get a chance to review this patch ?
>
> Yes, I've just did. Sorry it took that long.

No problem.

> Looks good, so
> Acked-by: <Geert Uytterhoeven <geert@linux-m68k.org>
>
> BTW, what's the plan with this series? Will you take care of it, or s=
hould
> all arch maintainers take their parts?
>

Uh .. I didn't really think much about that as I'm quite new to this.  =
    :)
It would be nice if everyone(including you) could just include their
respective patches in their trees/branches.

>> can I improve this patch in any way ?
>
> There are a few more or less minor things:
> =A0- You can remove "write" completely, as it's now superseded by
> =A0 =A0FAULT_FLAG_WRITE in "flags",
> =A0- Please also port the comments that were added to x86. They make
> =A0 =A0life easier for the casual reader.
>

should I send another patch for this ?
or do you want me to make a v2 of this patch and send it you today ?

> Thanks!
>
