Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52920 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJBGiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 02:38:15 -0400
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and
 lsm.disable=
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
 <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com>
 <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
 <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <0b6c66ab-7cfe-da99-40e7-d36a81ac79ef@canonical.com>
Date: Mon, 1 Oct 2018 16:57:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001235751._Vh09Se9lpWIFlJUzAcRgDJqA-OczHEeQx8fLyWlo0A@z>

On 10/01/2018 04:38 PM, Kees Cook wrote:
> On Mon, Oct 1, 2018 at 4:30 PM, Kees Cook <keescook@chromium.org> wrote:
>> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
>> enabled. Is that okay?
> 
> Actually, what the v3 series does right now is leaves AppArmor and
> SELinux alone -- whatever they configured for enable/disable is left
> alone.
> 
> The problem I have is when processing CONFIG_LSM_ENABLE ... what do I
> do with the existing "enable" flag? It's set by both
> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE and apparmor=0/1.
> 
> Right now I can't tell the difference between someone booting with
> apparmor=0 or CONFIG_LSM_ENABLE not including apparmor.
> 
> i.e. how do I mix CONFIG_LSM_ENABLE with apparmor=0/1? (assuming
> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE has been removed)
> 
right, Its a mess and confusing not just us but for the user. I think
it is worth considering removing the apparmor= and apparmor.enabled
options so that we can clean this up.

If we do keep it, there are three options
1. last option wins (above)
2. add more states so we can track the different combination (more
  complex and probably not worth it)
3. we ignore any apparmor=1 (he default state) and only look at
  whether apparmor.enabled has been toggled to 0 during setup. 
  At which point it stays that way.

if we keep it, I think an explicit disable should win, so
option 3, but I can live with 1.
