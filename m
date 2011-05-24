From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: (Short?) merge window reminder
Date: Tue, 24 May 2011 15:43:48 +0100
Message-ID: <20110524154348.27ba649d@lxorguk.ukuu.org.uk>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
	<20110523192056.GC23629@elte.hu>
	<BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
	<20110523231721.GM10009@thunk.org>
	<4DDAEC68.30803@zytor.com>
	<BANLkTikGfVSAMY2a2yiXaNpvBVvF8YdMEA@mail.gmail.com>
	<alpine.LNX.2.01.1105241409280.15351@frira.zrqbmnf.qr>
	<BANLkTimCXVdVa6KLRG8GJR1gJY=7_5SkOA@mail.gmail.com>
	<alpine.LNX.2.01.1105241500410.23085@frira.zrqbmnf.qr>
	<BANLkTinNK+9XijCN0YGXyvLQ8_npPTG2cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinNK+9XijCN0YGXyvLQ8_npPTG2cQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jacek Luczak <difrost.kernel@gmail.com>
Cc: Jan Engelhardt <jengelh@medozas.de>, linux-arch@vger.kernel.org, "linux-mm <linux-mm"@kvack.medozas.de, Ted Ts'o <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Can we drop most of MCA, EISA and ISA bus if we are going to have a big
version change ? A driver spring clean is much overdue and it's all in
git in case someone wishes to sneak out at midnight and bring some crawly
horror back from the dead.

Alan
