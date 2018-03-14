Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44777 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeCNREc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 13:04:32 -0400
MIME-Version: 1.0
In-Reply-To: <1521046285-9775-1-git-send-email-tklauser@distanz.ch>
References: <20180314143656.1495602-5-arnd@arndb.de> <1521046285-9775-1-git-send-email-tklauser@distanz.ch>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 18:04:30 +0100
Message-ID: <CAK8P3a38k3cR-Z2JqqdEagGCLqnj6O9q4K-+D7JfNmrECXD4wg@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkstack.pl: remove blackfin support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180314170430.yCb4TOVC2Ao_Ujw_CWvr0M-jbbKAcIfqp1t9NZunnqM@z>

On Wed, Mar 14, 2018 at 5:51 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> The Blackfin port has been removed from the kernel, also remove the
> blackfin specific bits from the checkstack.pl script.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Good catch, applied to my tree now.

Thanks!

      Arnd
