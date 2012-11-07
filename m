From: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: [RFC Patch v1 00/31] Synopsys ARC Linux kernel Port
Date: Wed, 7 Nov 2012 22:46:19 +0200
Message-ID: <CAOtvUMfjApPtjcsqr+comm-k90YH3WHSqFXyNPwJYyUXOouTqw@mail.gmail.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 7, 2012 at 11:47 AM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> Hi,
>
> This patchset based off-of 3.7-rc3, introduces the Linux kernel port to
> ARC700 processor family (750D and 770D) from Synopsys.


We've been using the port for 6 month now at Ezchip running on top of
FPGA in 4 way SMP configuration (support for which will no doubt
follow later) and have subjected it to various stress tests (hackbench
and such) and it is working up quite well over all.

I realize some code style or organization changes might be in order
but at the same time wanted to attest the nature of its good and
behavior performance on real hardware; so for what it's worth:

Tested-by: Gilad Ben-Yossef <gilad@benyossef.com>

Cheers,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker
gilad@benyossef.com
Israel Cell: +972-52-8260388
US Cell: +1-973-8260388
http://benyossef.com

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
