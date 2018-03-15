Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932838AbeCOX6a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 19:58:30 -0400
Date: Thu, 15 Mar 2018 16:42:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 15/16] recordmcount.pl: drop blackin and tile support
Message-ID: <20180315164113.1c6c3321@vmware.local.home>
In-Reply-To: <20180314145219.2055160-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314145219.2055160-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Kamil Rytarowski <n54@gmx.com>
Message-ID: <20180315204215.pMaZmtlejt_BVvRnUAsEutkVsqo20L6wVT4TwJ34O7Y@z>

On Wed, 14 Mar 2018 15:52:00 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> These two architectures are getting removed, so we no longer
> need the special cases.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  scripts/recordmcount.pl | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 2033af758173..c74ecc6504e8 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -368,14 +368,6 @@ if ($arch eq "x86_64") {
>  } elsif ($arch eq "microblaze") {
>      # Microblaze calls '_mcount' instead of plain 'mcount'.
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> -} elsif ($arch eq "blackfin") {
> -    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
> -    $mcount_adjust = -4;
> -} elsif ($arch eq "tilegx" || $arch eq "tile") {
> -    # Default to the newer TILE-Gx architecture if only "tile" is given.
> -    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
> -    $type = ".quad";
> -    $alignment = 8;
>  } else {
>      die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
>  }
