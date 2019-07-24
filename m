Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38428 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXKv3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2019 06:51:29 -0400
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Wed, 24 Jul 2019 11:51:17 +0100
Message-ID: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
Subject: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de
Message-ID: <20190724105117.yLa6hS4Yh0uaNkxNabtHGhL2KlwZ4CmxaG8va7tx0tY@z>

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
