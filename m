From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
Date: Mon, 1 Oct 2018 16:38:20 -0700
Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 1, 2018 at 4:30 PM, Kees Cook <keescook@chromium.org> wrote:
> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
> enabled. Is that okay?

Actually, what the v3 series does right now is leaves AppArmor and
SELinux alone -- whatever they configured for enable/disable is left
alone.

The problem I have is when processing CONFIG_LSM_ENABLE ... what do I
do with the existing "enable" flag? It's set by both
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE and apparmor=0/1.

Right now I can't tell the difference between someone booting with
apparmor=0 or CONFIG_LSM_ENABLE not including apparmor.

i.e. how do I mix CONFIG_LSM_ENABLE with apparmor=0/1? (assuming
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE has been removed)

-Kees

-- 
Kees Cook
Pixel Security
