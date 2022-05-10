Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A6C433FE
	for <linux-arch@archiver.kernel.org>; Tue, 10 May 2022 15:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiEJPmI (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 10 May 2022 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbiEJPls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 11:41:48 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FD1E21A5;
        Tue, 10 May 2022 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652197023; x=1683733023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZaeU8lUSOufc8Yfj/7fqq3unEqTIIuyyp2tOasU13k=;
  b=HkaibwYgIjg1mn78mPixjzcTqm+CWGS77QhOWAlNGO8cE/VWTtA6yrVE
   G4Q/stUJXIOesLBESvZzGJTB0qHGmpPOIvlcPChybjM43wMIrFA/SaU8/
   EnW+PlryOoFBy6x1+SC4Eiwp8dSeRWhyP7ECKCjnJirYCbXNtVb/KXYZP
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 08:37:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 08:37:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 08:37:01 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 08:37:00 -0700
Date:   Tue, 10 May 2022 11:36:58 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] fork: Make init and umh ordinary tasks
Message-ID: <20220510153658.GA159@qian>
References: <87a6czifo7.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx>
 <877d7zk1cf.ffs@tglx>
 <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx>
 <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
 <20220509204654.GA200@qian>
 <87r152xtko.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r152xtko.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 09, 2022 at 04:52:07PM -0500, Eric W. Biederman wrote:
> I believe this only happens when numa rebalancing happens at an
> unfortunate moment.
> 
> Qian Cai can you test this?

Yes, this works fine so far.
