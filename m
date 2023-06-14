Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB7EB64DA
	for <linux-arch@archiver.kernel.org>; Wed, 14 Jun 2023 07:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbjFNHPa (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 14 Jun 2023 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbjFNHP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 03:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628E98;
        Wed, 14 Jun 2023 00:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B93662FA9;
        Wed, 14 Jun 2023 07:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E8C433C8;
        Wed, 14 Jun 2023 07:15:23 +0000 (UTC)
Date:   Wed, 14 Jun 2023 08:15:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 5/5] perf arm-spe: Fix a dangling Documentation/arm64
 reference
Message-ID: <ZIlpCRXcdg4S9M8b@arm.com>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094606.334687-6-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 13, 2023 at 03:46:06AM -0600, Jonathan Corbet wrote:
> The arm64 documentation has moved under Documentation/arch/.  Fix up a
> dangling reference to match.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
