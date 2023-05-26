Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32FC7EE2E
	for <linux-arch@archiver.kernel.org>; Fri, 26 May 2023 02:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjEZC2z (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 25 May 2023 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjEZC2y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 22:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536E13D;
        Thu, 25 May 2023 19:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E8A64C5C;
        Fri, 26 May 2023 02:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15528C433D2;
        Fri, 26 May 2023 02:28:47 +0000 (UTC)
Date:   Thu, 25 May 2023 22:28:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230525222844.6a0d84f8@rorschach.local.home>
In-Reply-To: <20230525210040.3637-3-namit@vmware.com>
References: <20230525210040.3637-1-namit@vmware.com>
        <20230525210040.3637-3-namit@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 May 2023 14:00:39 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Functions that are marked as "inline" are currently also not tracable.
> This limits tracing functionality for many functions for no reason.
> Apparently, this has been done for two reasons.
> 
> First, as described in commit 5963e317b1e9d2a ("ftrace/x86: Do not
> change stacks in DEBUG when calling lockdep"), it was intended to
> prevent some functions that cannot be traced from being traced as these
> functions were marked as inline (among others).
> 
> Yet, this change has been done a decade ago, and according to Steven
> Rostedt, ftrace should have improved and hopefully resolved nested
> tracing issues by now. Arguably, if functions that should be traced -
> for instance since they are used during tracing - still exist, they
> should be marked as notrace explicitly.
> 
> The second reason, which Steven raised, is that attaching "notrace" to
> "inline" prevented tracing differences between different configs, which
> caused various problem. This consideration is not very strong, and tying
> "inline" and "notrace" does not seem very beneficial. The "inline"
> keyword is just a hint, and many functions are currently not tracable
> due to this reason.
> 
> Disconnect "inline" from "notrace".

FYI, I have a patch queued (still needs to go through testing) that
already does this ;-)

https://lore.kernel.org/all/20230502164102.1a51cdb4@gandalf.local.home/

-- Steve
