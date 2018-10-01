Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f181.google.com ([209.85.219.181]:46627 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJBEni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 00:43:38 -0400
Received: by mail-yb1-f181.google.com with SMTP id o8-v6so6293224ybk.13
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 15:03:43 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 137-v6sm7255747ywo.54.2018.10.01.15.03.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id s73-v6so6179282ywg.11
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-13-keescook@chromium.org>
 <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 15:03:39 -0700
Message-ID: <CAGXu5jK+WT-1QkapORpzBJDCeZSAXUf_tN0mwRU+cWy=phRdgA@mail.gmail.com>
Subject: Re: [PATCH security-next v3 12/29] LSM: Provide separate ordered initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001220339.OM4Ry5WZGjzbF0dhfvmg84NNK2yN2cvdFFHVRx75lUM@z>

On Mon, Oct 1, 2018 at 2:17 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> This provides a place for ordered LSMs to be initialized, separate from
>> the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
>> ordered_lsm_init(), but it will change drastically in later patches.
>>
>> What is not obvious in the patch is that this change moves the integrity
>> LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
>> with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
>> list, there is no reordering yet created.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I know its already being done, but I don't like splitting the init
> order

Can you describe what you mean here? Do you mean having two init
functions? This is only done temporarily while the other pieces are
reorganized. The later patches reintegrate this. (Before this series,
we effectively had three implicit init paths: minor, major, and
integrity, so even this patch "alone" is an improvement IMO.)

Thanks for the reviews!

-Kees

-- 
Kees Cook
Pixel Security
