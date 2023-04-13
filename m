Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A474DC77B77
	for <linux-arch@archiver.kernel.org>; Thu, 13 Apr 2023 22:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDMWxc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 13 Apr 2023 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjDMWx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 18:53:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B2E1FFC
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 15:53:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j2-20020a170902da8200b001a055243657so8782606plx.19
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681426404; x=1684018404;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8guo045Q+5eAEwhfUr30hz0PJkqMwxW7HV3gxeLbUM=;
        b=Rjwp4Xdm6ZLaEPgG8cQHjLF9ituKkBuE4Kg1flS/uBoAlJ5LElw7Yfif+urjga4Z1k
         Id9XGYBIPjUILBU5HRcXu81p8pDXA/u7T7lfZ53bFi0pGFkAASoZMc1FKWQlhEzWj7g7
         M8ApiMQugbqBdsiM2beP1Zmsfm7UP5aAC4H3s81SX9hYygeAlfdJWkF78OhRMgmv5bOY
         YVoHszS0N47VwRyOsgUt/J/+QeiNlvAv36oX5BxahWlc22nXKEGI9AqKs9w9dhKamSyI
         7JyyYvDzq5fdoA1a6pagi9+JsHhlJPaWALPTL0IkyyyP5IWH3eftfLt0+7o6zZeS826/
         vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681426404; x=1684018404;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8guo045Q+5eAEwhfUr30hz0PJkqMwxW7HV3gxeLbUM=;
        b=kuRuhiepV1jh0C15MP6FPykpT3EDTWSiLhHn3PzsZAYeJvH7Gmpblzqh7H9B7uSpUd
         48fWzxzjZn9qqitNcK9TlJl7wrCbO6/uIrakGGDIHOmX9GW1mdzHnT6fTw9OmMedP3D3
         zFTmiMIZHWt7X61bgF/ym9x9YNum8udB06DAnJO/mQUb/vJjQITIG9zSB5nzlZLm2D1P
         za9JH8+DUzAhUj2va9b0cUGQVxO+WLm9DZ5zZVWWOlTOaW0H6SlQduGrRv9jZTmpElb6
         gMp/IfdjDx84qhQmHoa1I6d6wfKkGb3cDmmZ6g/cQsoyKo31InuCpOaEmuazlxUTpfg+
         WEgQ==
X-Gm-Message-State: AAQBX9fGJ+JvQj0+xc9bEBmkFZrXol3/BOzDowOdr6i+8jxyY5Bg0b85
        5BSv97qtNdCgpIMz/reicAn3X6St6MOrw57lnQ==
X-Google-Smtp-Source: AKy350ZDf9SfJRuS6hlT3xzlEOA5lECkBtR1nsxMCxij1QGPtfZHXE7tqJcIaT1y2UkRtOi3D6c9Q8ilUDsupR7kxA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:3ea7:b0:246:f5c3:576 with SMTP
 id k36-20020a17090a3ea700b00246f5c30576mr979461pjc.6.1681426404283; Thu, 13
 Apr 2023 15:53:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:53:22 +0000
In-Reply-To: <20230412-kurzweilig-unsummen-3c1136f7f437@brauner> (message from
 Christian Brauner on Wed, 12 Apr 2023 11:59:52 +0200)
Mime-Version: 1.0
Message-ID: <diqzedono0m5.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Apr 05, 2023 at 09:58:44PM +0000, Ackerley Tng wrote:

>> ...

>> > > Why do you even need this flag? It seems that @mount_fd being < 0 is
>> > > sufficient to indicate that a new restricted memory fd is supposed  
>> to be
>> > > created in the system instance.


>> I'm hoping to have this patch series merged after Chao's patch series
>> introduces the memfd_restricted() syscall [1].

> I'm curious, is there an LSFMM session for this?

As far as I know, there is no LSFMM session for this.
