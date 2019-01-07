Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:53938 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAGCwk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jan 2019 21:52:40 -0500
Date: Mon, 7 Jan 2019 05:52:36 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v7 01/22] asm-generic/syscall.h: prepare for inclusion by
 other files
Message-ID: <20190107025236.GA1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190107025236.XtZcB4Famz2vGJJK3hlXOc6Vgfmlm7145IkeYVI7EBk@z>
