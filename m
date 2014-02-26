From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] bug: When !CONFIG_BUG, make WARN call no_printk to check format and args
Date: Wed, 26 Feb 2014 14:25:49 +0100
Message-ID: <201402261425.49779.arnd@arndb.de>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org> <770b3955bdcec63564ae09741ae154f8908c22c6.1393385236.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <770b3955bdcec63564ae09741ae154f8908c22c6.1393385236.git.josh@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 26 February 2014, Josh Triplett wrote:
> The stub version of WARN for !CONFIG_BUG completely ignored its format
> string and subsequent arguments; make it check them instead, using
> no_printk.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
