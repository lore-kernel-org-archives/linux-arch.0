From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] scripts/checkstack.pl: remove blackfin support
Date: Wed, 14 Mar 2018 18:04:30 +0100
Message-ID: <CAK8P3a38k3cR-Z2JqqdEagGCLqnj6O9q4K-+D7JfNmrECXD4wg@mail.gmail.com>
References: <20180314143656.1495602-5-arnd@arndb.de> <1521046285-9775-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521046285-9775-1-git-send-email-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 5:51 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> The Blackfin port has been removed from the kernel, also remove the
> blackfin specific bits from the checkstack.pl script.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Good catch, applied to my tree now.

Thanks!

      Arnd
