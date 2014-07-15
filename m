Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:49333 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbaGOJih (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:38:37 -0400
MIME-Version: 1.0
In-Reply-To: <20140715090813.GE7668@distanz.ch>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<20140715090813.GE7668@distanz.ch>
Date: Tue, 15 Jul 2014 17:38:36 +0800
Message-ID: <CAFiDJ5-YNB_uctBYFGkoABHfnwhuncy2FGrQk1j0qPVZBDrC3g@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] nios2 Linux kernel port
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140715093836.Z9hmTdkxy43NgjGZ160tFGRJ3K0SW8KHN_oFmN1bZao@z>

On Tue, Jul 15, 2014 at 5:08 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2014-07-15 at 10:45:27 +0200, Ley Foon Tan <lftan@altera.com> wrote:

>
> Very nice work Ley Foon! It's great to see the Nios II port finally
> making it upstream.
>
> I'll test the series on the NEEK and my custom board some time this
> week.

Hi Tobias

FYI, you need new compiler that support generic ABI syscall. But, this
new compiler is not public available yet.
Will let you know once it is available.

Ley Foon
