From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Mon, 7 Dec 2015 21:52:31 -0800
Message-ID: <CALCETrXSS3K8v_o18F50nmdUtZ1DAhnbmFtnLgrqwH1SXPxiOg@mail.gmail.com>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel> <20151208043648.GA2182@gmail.com>
 <20151208044937.GK20997@ZenIV.linux.org.uk> <20151208050148.GA3968@gmail.com> <20151208051505.GL20997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151208051505.GL20997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 7, 2015 at 9:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Dec 08, 2015 at 06:01:48AM +0100, Ingo Molnar wrote:
>
>> Hm, so if Sparc has no notion of compat-ness of the system call then how does it
>> implement runtime compat checks, such as AUDIT_ARCH et al?
>
> Badly.  Things like compat_sys_ioctl() vs. ioctl() work (we use different
> arrays of function pointers in 32bit and 64bit traps), but anything
> dynamic assumes that things match the task.  Not that we had a lot of
> such dynamic checks, actually...

I wouldn't take x86 as a shining example of how to do this, but it
does mostly work.  In 4.4, it's not even all that messy, modulo a
bunch of checks that check the wrong condition (hence, in part, this
proposal).

--Andy
