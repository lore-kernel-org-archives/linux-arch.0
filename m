From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] kbuild: CRC versions for asm functions
Date: Sat, 15 Oct 2016 23:43:50 +1100
Message-ID: <20161015124352.10795-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35405 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbcJOMoL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2016 08:44:11 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

Hi,

Here's what I've got to deal with the asm exports issue. This will
require arch patches to add asm/asm-prototypes.h that gets picked
up by kbuild.

Any comments? Objections?

Thanks,
Nick
