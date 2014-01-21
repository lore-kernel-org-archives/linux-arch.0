From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/73] arm: use subsys_initcall in non-modular pl320 IPC code
Date: Tue, 21 Jan 2014 22:44:21 +0100
Message-ID: <4922482.oeJaTIvZxl@wuerfel>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 21 January 2014 16:22:23 Paul Gortmaker wrote:
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of subsys_initcall (which
> seems to make sense for netfilter code) will thus change this
> registration from level 6-device to level 4-subsys (i.e. slightly
> earlier).  However no impact of that small difference is expected.

This doesn't have anything to do with netfilter. The only user
of this driver at the moment is the highbank cpufreq driver, but
that could change.

	Arnd
