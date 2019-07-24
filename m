From: Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
Date: Wed, 24 Jul 2019 11:51:17 +0100
Message-ID: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

Hi, everyone,

I don't know if this has been reported before, but from a cursory
search it doesn't seem to be the case.
I have a x86-64 Pentium (4) D machine which always worked perfectly
with Linux 5.2 using the TSC as the clock source. With Linux 5.3-rc1 I
can't, for the life of me, boot it with anything other than
clocksource=jiffies, it completely hangs without even a backtrace.
At the moment I'm at work and, for obvious reasons, I'm not able to
bisect this remotely. In any case, if anyone has any idea about the
cause, I'll be glad to help debugging and testing any patches.

Thanks in advance,
Rui
