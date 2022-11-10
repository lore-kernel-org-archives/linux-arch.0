Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24812C433FE
	for <linux-arch@archiver.kernel.org>; Thu, 10 Nov 2022 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKJRxi (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKJRxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Nov 2022 12:53:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75434240B0
        for <linux-arch@vger.kernel.org>; Thu, 10 Nov 2022 09:53:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so5918044pjh.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Nov 2022 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oKQDlB6eYx+fAXvKZFnqwvhnIR4JQKKCXs9/v8+asA=;
        b=USq4b5Vh1OXggTCD0w44axvUCuw0wgwmRJONRIlB95PFBRewtOpmoKc7I2XbMFe+Jt
         py6SLDlrcfHe9Q3VO4+7dfiMGs6dPX9qHKjrdWteekp4+U/DoQ8k4+BtA12MyhPAKSwW
         oWUbDGwbmbtRu0HlyiAF1gzP3/dmYGn+4ag1yp2zQxUQz3Y8R8NAepQDJa1zRgnFTAwp
         482q2MupCDGAkGCVertYK1p6MwGRwEAvRckuUOPwVBujunwWETFLz4d1bnde8cgKCLkj
         6U6T7ZnM4yWVZOheoRcwISEPaZCMlXQ5G+O2GSFI15kWlhWhoPX3ZMRej3KuRu/bUqnC
         oRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oKQDlB6eYx+fAXvKZFnqwvhnIR4JQKKCXs9/v8+asA=;
        b=inHE2f1UYo2piJuVy4aKTAjT2z7+xxZr/6HR0IdVQcy+c1qMyMEQ0ZwNoWmm87xigl
         G3TAbpI1GWYiXyZiSsdw4moM5iVoaG+6wY31l7/O28NaUdVQstPCqoUNqSNEI46zlu2d
         /B5CHflVdHoQK3n09wuXnLdgacnBtWQBXFRd949RA/ASzN4LMP85oNOMVwX665GoPu5H
         5bkKhOXtX2HDrU+aSBBmiknNV9hUC3NeA/d9fqoq1RDY/6wh3OOHw3FemTgmW1mdXWmj
         Pwhdm12eEAaj94CTvinCOIAuupurBoPKcQgJYQ3iUiD6iGma+TGbh5/qUtZQTzxV2PXN
         2bhQ==
X-Gm-Message-State: ANoB5pnz35bqZYWmH2ndrH0NbIpOgDtt5QHEn1+rspiQcKGwPnROH7Jd
        gcxH/t2PYrtJcdq+WoeiXi1Bzw==
X-Google-Smtp-Source: AA0mqf5Tm7voUfqlq46fUuj/FQZ0U+LCKMGUSx8RMJOkkJOakWUAIRLRpdmCoJrBserqv+E6AVAQEA==
X-Received: by 2002:a17:903:120f:b0:188:82fc:e259 with SMTP id l15-20020a170903120f00b0018882fce259mr18758217plh.61.1668102813812;
        Thu, 10 Nov 2022 09:53:33 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b00172e19c5f8bsm11666966pla.168.2022.11.10.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:53:33 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:53:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
Message-ID: <Y206mVuJlXjO10qx@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
 <CA+EHjTySnJTuLB+XoRya6kS_zw2iMahW9-Ze70oKTf+6k0GrGQ@mail.gmail.com>
 <20221104022813.GA4129873@chaop.bj.intel.com>
 <Y2WSXLtcJOpWPtuv@google.com>
 <20221108071624.GA76278@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108071624.GA76278@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 08, 2022, Chao Peng wrote:
> On Fri, Nov 04, 2022 at 10:29:48PM +0000, Sean Christopherson wrote:
> > The APICv case that this was added for could very well be broken because of
> > this, and the resulting failures would be an absolute nightmare to debug.
> 
> Given the apicv_inhibit should be rare, the change looks good to me.
> Just to be clear, your will send out this fix, right?

Ya, I'll post an official patch.
