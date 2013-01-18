From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 63/76] ARC: Hostlink Pseudo-Driver for Metaware Debugger
Date: Fri, 18 Jan 2013 14:58:26 +0000
Message-ID: <201301181458.26891.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-64-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-64-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> +static int arc_hl_nr_devs = 1;

This seems to be read-only and hardcoded to 1. If this is true, you could
simplify the driver significantly by just using misc_register, rather
than registering your own major device number.

	Arnd
