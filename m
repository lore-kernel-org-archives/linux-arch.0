From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] bug: Fix build error in V4.2-RC1
Date: Sun, 12 Jul 2015 08:52:08 -0700
Message-ID: <1436716328.2711.77.camel@perches.com>
References: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, 2015-07-12 at 10:00 -0500, Larry Finger wrote:
> If CONFIG_BUG is not defined, then macro __WARN is not defined.
[]
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
[]
> @@ -137,6 +137,7 @@ extern void warn_slowpath_null(const char *file, const int line);

> +#define __WARN() do {} while (1)

Do you really think WARN should loop forever?
