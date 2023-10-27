Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAFBC25B47
	for <linux-arch@archiver.kernel.org>; Fri, 27 Oct 2023 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjJ0LEp (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 27 Oct 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjJ0LEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 07:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9E187;
        Fri, 27 Oct 2023 04:04:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAC0C433C8;
        Fri, 27 Oct 2023 11:04:35 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:04:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        David Hildenbrand <david@redhat.com>, will@kernel.org,
        oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
        akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
        pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <ZTuZQYjcYFILtGYI@arm.com>
References: <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
 <ZOd2LvUKMguWdlgq@arm.com>
 <ZPhfNVWXhabqnknK@monolith>
 <ZP7/e8YFiosElvTm@arm.com>
 <0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com>
 <ZQHVVdlN9QQztc7Q@arm.com>
 <CGME20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89@epcas2p4.samsung.com>
 <20231025025932.GA3953138@tiffany>
 <ZTjWKJ0K78jeCJr-@monolith>
 <20231025085258.GA1355131@tiffany>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025085258.GA1355131@tiffany>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 25, 2023 at 05:52:58PM +0900, Hyesoo Yu wrote:
> If we only avoid using ALLOC_CMA for __GFP_TAGGED, would we still be able to use
> the next iteration even if the hardware does not support "tag of tag" ? 

It depends on how the next iteration looks like. The plan was not to
support this so that we avoid another complication where a non-tagged
page is mprotect'ed to become tagged and it would need to be migrated
out of the CMA range. Not sure how much code it would save.

> I am not sure every vendor will support tag of tag, since there is no information
> related to that feature, like in the Google spec document.

If you are aware of any vendors not supporting this, please direct them
to the Arm support team, it would be very useful information for us.

Thanks.

-- 
Catalin
