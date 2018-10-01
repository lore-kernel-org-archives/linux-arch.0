From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
Date: Mon, 1 Oct 2018 16:49:57 -0700
Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
 <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 1, 2018 at 4:44 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/01/2018 04:30 PM, Kees Cook wrote:
>> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
>> enabled. Is that okay?
>>
> ugh I would rather get rid of apparmor=0 or to emit a warning with apparmor
> disabled, but if we have to live with it then yes I can live with last
> option wins

Removing it would be much preferred! :)

Assuming Paul is okay with the same results in SELinux, I'll prepare patches...

-Kees

-- 
Kees Cook
Pixel Security
