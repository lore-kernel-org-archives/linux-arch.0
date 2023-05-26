Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3477C7EE2C
	for <linux-arch@archiver.kernel.org>; Fri, 26 May 2023 05:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjEZFk2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 26 May 2023 01:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjEZFk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 01:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE118D;
        Thu, 25 May 2023 22:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BABD64CE4;
        Fri, 26 May 2023 05:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66082C433EF;
        Fri, 26 May 2023 05:40:22 +0000 (UTC)
Date:   Fri, 26 May 2023 01:40:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
        linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230526014018.5ebafc55@rorschach.local.home>
In-Reply-To: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
        <20230525210040.3637-3-namit@vmware.com>
        <20230525222844.6a0d84f8@rorschach.local.home>
        <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 May 2023 22:17:33 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> Ugh. If you cc’d me, I wouldn’t bother you during your vacation. :)

Oh, and if you are interested in tracing patches, just subscribe to
linux-trace-kernel@vger.kernel.org.

-- Steve
