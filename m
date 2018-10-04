From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Thu, 4 Oct 2018 10:42:09 -0700
Message-ID: <CAGXu5jJksqQDOYZy_HyQNgUTNauOw40APfKSop+viXh5bcXmSA@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
 <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com>
 <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com> <CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com>
 <QlTG4dQyxeJfFuHbDfQswJ-FPDDZAOn5tyV7I0oSdFNyYRX1WrbTJP9zw0SWoAb0b0m1bE0Do2aHxA8V0qzX9X8g3hsiLLdw7EuFLbAjcAM=@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <QlTG4dQyxeJfFuHbDfQswJ-FPDDZAOn5tyV7I0oSdFNyYRX1WrbTJP9zw0SWoAb0b0m1bE0Do2aHxA8V0qzX9X8g3hsiLLdw7EuFLbAjcAM=@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 4, 2018 at 10:40 AM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> Sent with ProtonMail Secure Email.
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, October 4, 2018 6:18 PM, Kees Cook <keescook@chromium.org> w=
rote:
>
>>
>> I don't want to overload "security=3D", but we can if we want. It would
>> be as above, but a trailing comma would be needed to trigger the
>> "ordering" behavior. e.g. "security=3Dselinux" would disable all other
>> majors (retaining the current behavior), but "security=3Dselinux," would
>> disable all other LSMs.
>>
>> -Kees
>>
>>
>
> I don't think giving such big impact to trailing comma is good idea :)

That's why I prefer a new lsm=3D instead of confusing security=3D. :)

-Kees

--=20
Kees Cook
Pixel Security
