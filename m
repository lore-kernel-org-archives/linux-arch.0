From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 16/24] C6X: cache control
Date: Wed, 28 Sep 2011 15:52:34 +0200
Message-ID: <201109281552.34322.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-17-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317155405-26235-17-git-send-email-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/include/asm/cache.h      |   90 ++++++++
>  arch/c6x/include/asm/cacheflush.h |   65 ++++++
>  arch/c6x/platforms/cache.c        |  445 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 600 insertions(+), 0 deletions(-)
>  create mode 100644 arch/c6x/include/asm/cache.h
>  create mode 100644 arch/c6x/include/asm/cacheflush.h
>  create mode 100644 arch/c6x/platforms/cache.c

Acked-by: Arnd Bergmann <arnd@arndb.de>
