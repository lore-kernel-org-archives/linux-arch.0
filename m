From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] PMIC / opregion: support PMIC customized operation
 region for CrystalCove
Date: Wed, 8 Oct 2014 09:05:15 +0100
Message-ID: <20141008080515.GC20647@lee--X1>
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com>
 <1410229968-11638-3-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410229968-11638-3-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@linaro.org>
List-Id: linux-arch.vger.kernel.org

To all those CC'ed,

> The Baytrail-T platform firmware has defined two customized operation
> regions for PMIC chip Crystal Cove - one is for power resource handli=
ng
> and one is for thermal: sensor temperature reporting, trip point sett=
ing,
> etc. This patch adds support for them on top of the existing Crystal =
Cove
> PMIC driver.
>=20
> The reason to split code into a separate file intel_soc_pmic_opregion=
=2Ec
> is that there are more PMIC driver with ACPI operation region support
> coming and we can re-use those code. The intel_soc_pmic_opregion_data
> structure is created also for this purpose: when we need to support a
> new PMIC's operation region, we just need to fill those callbacks and
> the two register mapping tables.
>=20
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/mfd/Kconfig                       |  11 +
>  drivers/mfd/Makefile                      |   1 +
>  drivers/mfd/intel_soc_pmic_crc.c          |   3 +
>  drivers/mfd/intel_soc_pmic_crc_opregion.c | 229 +++++++++++++++++++
>  drivers/mfd/intel_soc_pmic_opregion.c     | 350 ++++++++++++++++++++=
++++++++++
>  drivers/mfd/intel_soc_pmic_opregion.h     |  35 +++

With the influx of new same-chip devices, I think the MFD subsystem is
fast becoming overloaded.  I think all of the PMIC handling should in
fact either live in Regulators or have its own subsystem.

Let's open this up to the floor by Cc'ing some probable interested
parties.

[Leaving the driver code in, but my comments stop here]

>  6 files changed, 629 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_crc_opregion.c
>  create mode 100644 drivers/mfd/intel_soc_pmic_opregion.c
>  create mode 100644 drivers/mfd/intel_soc_pmic_opregion.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index de5abf244746..77a7229058a6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -266,6 +266,17 @@ config INTEL_SOC_PMIC
>  	  thermal, charger and related power management functions
>  	  on these systems.
> =20
> +config CRC_PMIC_OPREGION
> +	tristate "ACPI operation region support for CrystalCove PMIC"
> +	depends on ACPI
> +	depends on INTEL_SOC_PMIC
> +	help
> +	  Select this option to enable support for ACPI operation
> +	  region of the PMIC chip. The operation region can be used
> +	  to control power rails and sensor reading/writing on the
> +	  PMIC chip. This config addes ACPI operation region support
> +	  for CrystalCove PMIC.
> +
>  config MFD_INTEL_MSIC
>  	bool "Intel MSIC"
>  	depends on INTEL_SCU_IPC
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f00148782d9b..e02f0573e293 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -172,3 +172,4 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+=3D ipaq-micro.o
> =20
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> +obj-$(CONFIG_CRC_PMIC_OPREGION) +=3D intel_soc_pmic_crc_opregion.o i=
ntel_soc_pmic_opregion.o
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc=
_pmic_crc.c
> index 7107cab832e6..48845d636bba 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -106,6 +106,9 @@ static struct mfd_cell crystal_cove_dev[] =3D {
>  		.num_resources =3D ARRAY_SIZE(gpio_resources),
>  		.resources =3D gpio_resources,
>  	},
> +	{
> +		.name =3D "crystal_cove_region",
> +	},
>  };
> =20
>  static struct regmap_config crystal_cove_regmap_config =3D {
> diff --git a/drivers/mfd/intel_soc_pmic_crc_opregion.c b/drivers/mfd/=
intel_soc_pmic_crc_opregion.c
> new file mode 100644
> index 000000000000..27b67dc3fa8d
> --- /dev/null
> +++ b/drivers/mfd/intel_soc_pmic_crc_opregion.c
> @@ -0,0 +1,229 @@
> +/*
> + * intel_soc_pmic_crc_opregion.c - Intel SoC PMIC operation region D=
river
> + *
> + * Copyright (C) 2014 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License versi=
on
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include "intel_soc_pmic_opregion.h"
> +
> +#define PWR_SOURCE_SELECT	BIT(1)
> +
> +#define PMIC_A0LOCK_REG		0xc5
> +
> +static struct pmic_pwr_table pwr_table[] =3D {
> +	{
> +		.address =3D 0x24,
> +		.pwr_reg =3D {
> +			.reg =3D 0x66,
> +			.bit =3D 0x00,
> +		},
> +	},	/* X285 -> V2P85SX, camara */
> +	{
> +		.address =3D 0x48,
> +		.pwr_reg =3D {
> +			.reg =3D 0x5d,
> +			.bit =3D 0x00,
> +		},
> +	},	/* V18X -> V1P8SX, eMMC/camara/audio */
> +};
> +
> +static struct pmic_dptf_table dptf_table[] =3D {
> +	{
> +		.address =3D 0x00,
> +		.reg =3D 0x75
> +	},	/* TMP0 -> SYS0_THRM_RSLT_L */
> +	{
> +		.address =3D 0x04,
> +		.reg =3D 0x95
> +	},	/* AX00 -> SYS0_THRMALRT0_L */
> +	{
> +		.address =3D 0x08,
> +		.reg =3D 0x97
> +	},	/* AX01 -> SYS0_THRMALRT1_L */
> +	{
> +		.address =3D 0x0c,
> +		.reg =3D 0x77
> +	},	/* TMP1 -> SYS1_THRM_RSLT_L */
> +	{
> +		.address =3D 0x10,
> +		.reg =3D 0x9a
> +	},	/* AX10 -> SYS1_THRMALRT0_L */
> +	{
> +		.address =3D 0x14,
> +		.reg =3D 0x9c
> +	},	/* AX11 -> SYS1_THRMALRT1_L */
> +	{
> +		.address =3D 0x18,
> +		.reg =3D 0x79
> +	},	/* TMP2 -> SYS2_THRM_RSLT_L */
> +	{
> +		.address =3D 0x1c,
> +		.reg =3D 0x9f
> +	},	/* AX20 -> SYS2_THRMALRT0_L */
> +	{
> +		.address =3D 0x20,
> +		.reg =3D 0xa1
> +	},	/* AX21 -> SYS2_THRMALRT1_L */
> +	{
> +		.address =3D 0x48,
> +		.reg =3D 0x94
> +	},	/* PEN0 -> SYS0_THRMALRT0_H */
> +	{
> +		.address =3D 0x4c,
> +		.reg =3D 0x99
> +	},	/* PEN1 -> SYS1_THRMALRT1_H */
> +	{
> +		.address =3D 0x50,
> +		.reg =3D 0x9e
> +	},	/* PEN2 -> SYS2_THRMALRT2_H */
> +};
> +
> +static int intel_crc_pmic_get_power(struct regmap *regmap,
> +				    struct pmic_pwr_reg *preg, u64 *value)
> +{
> +	int data;
> +
> +	if (regmap_read(regmap, preg->reg, &data))
> +		return -EIO;
> +
> +	*value =3D (data & PWR_SOURCE_SELECT) && (data & BIT(preg->bit)) ? =
1 : 0;
> +	return 0;
> +}
> +
> +static int intel_crc_pmic_update_power(struct regmap *regmap,
> +				       struct pmic_pwr_reg *preg, bool on)
> +{
> +	int data;
> +
> +	if (regmap_read(regmap, preg->reg, &data))
> +		return -EIO;
> +
> +	if (on) {
> +		data |=3D PWR_SOURCE_SELECT | BIT(preg->bit);
> +	} else {
> +		data &=3D ~BIT(preg->bit);
> +		data |=3D PWR_SOURCE_SELECT;
> +	}
> +
> +	if (regmap_write(regmap, preg->reg, data))
> +		return -EIO;
> +	return 0;
> +}
> +
> +/* Raw temperature value is 10bits: 8bits in reg and 2bits in reg-1 =
bit0,1 */
> +static int intel_crc_pmic_get_raw_temp(struct regmap *regmap, int re=
g)
> +{
> +	int temp_l, temp_h;
> +
> +	if (regmap_read(regmap, reg, &temp_l) ||
> +	    regmap_read(regmap, reg - 1, &temp_h))
> +		return -EIO;
> +
> +	return (temp_l | ((temp_h & 0x3) << 8));
> +}
> +
> +static int
> +intel_crc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
> +{
> +	if (regmap_write(regmap, reg, raw) ||
> +	    regmap_update_bits(regmap, reg - 1, 0x3, raw >> 8))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int
> +intel_crc_pmic_get_policy(struct regmap *regmap, int reg, u64 *value=
)
> +{
> +	int pen;
> +
> +	if (regmap_read(regmap, reg, &pen))
> +		return -EIO;
> +	*value =3D pen >> 7;
> +	return 0;
> +}
> +
> +static int intel_crc_pmic_update_policy(struct regmap *regmap,
> +					int reg, int enable)
> +{
> +	int alert0;
> +
> +	/* Update to policy enable bit requires unlocking a0lock */
> +	if (regmap_read(regmap, PMIC_A0LOCK_REG, &alert0))
> +		return -EIO;
> +	if (regmap_update_bits(regmap, PMIC_A0LOCK_REG, 0x01, 0))
> +		return -EIO;
> +
> +	if (regmap_update_bits(regmap, reg, 0x80, enable << 7))
> +		return -EIO;
> +
> +	/* restore alert0 */
> +	if (regmap_write(regmap, PMIC_A0LOCK_REG, alert0))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static struct intel_soc_pmic_opregion_data intel_crc_pmic_opregion_d=
ata =3D {
> +	.get_power	=3D intel_crc_pmic_get_power,
> +	.update_power	=3D intel_crc_pmic_update_power,
> +	.get_raw_temp	=3D intel_crc_pmic_get_raw_temp,
> +	.update_aux	=3D intel_crc_pmic_update_aux,
> +	.get_policy	=3D intel_crc_pmic_get_policy,
> +	.update_policy	=3D intel_crc_pmic_update_policy,
> +	.pwr_table	=3D pwr_table,
> +	.pwr_table_count=3D ARRAY_SIZE(pwr_table),
> +	.dptf_table	=3D dptf_table,
> +	.dptf_table_count =3D ARRAY_SIZE(dptf_table),
> +};
> +
> +static int intel_crc_pmic_opregion_probe(struct platform_device *pde=
v)
> +{
> +	struct intel_soc_pmic *pmic =3D dev_get_drvdata(pdev->dev.parent);
> +	return intel_soc_pmic_install_opregion_handler(&pdev->dev,
> +			ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
> +			&intel_crc_pmic_opregion_data);
> +}
> +
> +static int intel_crc_pmic_opregion_remove(struct platform_device *pd=
ev)
> +{
> +	intel_soc_pmic_remove_opregion_handler(ACPI_HANDLE(pdev->dev.parent=
));
> +	return 0;
> +}
> +
> +#define DRV_NAME "crystal_cove_region"
> +
> +static struct platform_device_id crystal_cove_opregion_id_table[] =3D=
 {
> +	{ .name =3D DRV_NAME },
> +	{},
> +};
> +
> +static struct platform_driver intel_crc_pmic_opregion_driver =3D {
> +	.probe =3D intel_crc_pmic_opregion_probe,
> +	.remove =3D intel_crc_pmic_opregion_remove,
> +	.id_table =3D crystal_cove_opregion_id_table,
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +	},
> +};
> +
> +MODULE_DEVICE_TABLE(platform, crystal_cove_opregion_id_table);
> +
> +module_platform_driver(intel_crc_pmic_opregion_driver);
> +
> +MODULE_DESCRIPTION("CrystalCove ACPI opregion driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/intel_soc_pmic_opregion.c b/drivers/mfd/inte=
l_soc_pmic_opregion.c
> new file mode 100644
> index 000000000000..62824a35ce97
> --- /dev/null
> +++ b/drivers/mfd/intel_soc_pmic_opregion.c
> @@ -0,0 +1,350 @@
> +/*
> + * intel_soc_pmic_opregion.c - Intel SoC PMIC operation region Drive=
r
> + *
> + * Copyright (C) 2014 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License versi=
on
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +#include "intel_soc_pmic_opregion.h"
> +
> +#define PMIC_PMOP_OPREGION_ID	0x8d
> +#define PMIC_DPTF_OPREGION_ID	0x8c
> +
> +struct acpi_lpat {
> +	int temp;
> +	int raw;
> +};
> +
> +struct intel_soc_pmic_opregion {
> +	struct mutex lock;
> +	struct acpi_lpat *lpat;
> +	int lpat_count;
> +	struct regmap *regmap;
> +	struct intel_soc_pmic_opregion_data *data;
> +};
> +
> +static struct pmic_pwr_reg *
> +pmic_get_pwr_reg(int address, struct pmic_pwr_table *table, int coun=
t)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (table[i].address =3D=3D address)
> +			return &table[i].pwr_reg;
> +	}
> +	return NULL;
> +}
> +
> +static int
> +pmic_get_dptf_reg(int address, struct pmic_dptf_table *table, int co=
unt)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (table[i].address =3D=3D address)
> +			return table[i].reg;
> +	}
> +	return -ENOENT;
> +}
> +
> +/* Return temperature from raw value through LPAT table */
> +static int raw_to_temp(struct acpi_lpat *lpat, int count, int raw)
> +{
> +	int i, delta_temp, delta_raw, temp;
> +
> +	for (i =3D 0; i < count - 1; i++) {
> +		if ((raw >=3D lpat[i].raw && raw <=3D lpat[i+1].raw) ||
> +		    (raw <=3D lpat[i].raw && raw >=3D lpat[i+1].raw))
> +			break;
> +	}
> +
> +	if (i =3D=3D count - 1)
> +		return -ENOENT;
> +
> +	delta_temp =3D lpat[i+1].temp - lpat[i].temp;
> +	delta_raw =3D lpat[i+1].raw - lpat[i].raw;
> +	temp =3D lpat[i].temp + (raw - lpat[i].raw) * delta_temp / delta_ra=
w;
> +
> +	return temp;
> +}
> +
> +/* Return raw value from temperature through LPAT table */
> +static int temp_to_raw(struct acpi_lpat *lpat, int count, int temp)
> +{
> +	int i, delta_temp, delta_raw, raw;
> +
> +	for (i =3D 0; i < count - 1; i++) {
> +		if (temp >=3D lpat[i].temp && temp <=3D lpat[i+1].temp)
> +			break;
> +	}
> +
> +	if (i =3D=3D count - 1)
> +		return -ENOENT;
> +
> +	delta_temp =3D lpat[i+1].temp - lpat[i].temp;
> +	delta_raw =3D lpat[i+1].raw - lpat[i].raw;
> +	raw =3D lpat[i].raw + (temp - lpat[i].temp) * delta_raw / delta_tem=
p;
> +
> +	return raw;
> +}
> +
> +static void
> +pmic_dptf_lpat(struct intel_soc_pmic_opregion *opregion, acpi_handle=
 handle,
> +	       struct device *dev)
> +{
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj_p, *obj_e;
> +	int *lpat, i;
> +	acpi_status status;
> +
> +	status =3D acpi_evaluate_object(handle, "LPAT", NULL, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	obj_p =3D (union acpi_object *)buffer.pointer;
> +	if (!obj_p || (obj_p->type !=3D ACPI_TYPE_PACKAGE) ||
> +	    (obj_p->package.count % 2) || (obj_p->package.count < 4))
> +		goto out;
> +
> +	lpat =3D devm_kmalloc(dev, sizeof(*lpat) * obj_p->package.count,
> +			    GFP_KERNEL);
> +	if (!lpat)
> +		goto out;
> +
> +	for (i =3D 0; i < obj_p->package.count; i++) {
> +		obj_e =3D &obj_p->package.elements[i];
> +		if (obj_e->type !=3D ACPI_TYPE_INTEGER)
> +			goto out;
> +		lpat[i] =3D obj_e->integer.value;
> +	}
> +
> +	opregion->lpat =3D (struct acpi_lpat *)lpat;
> +	opregion->lpat_count =3D obj_p->package.count / 2;
> +
> +out:
> +	kfree(buffer.pointer);
> +}
> +
> +static acpi_status
> +intel_soc_pmic_pmop_handler(u32 function, acpi_physical_address addr=
ess,
> +			    u32 bits, u64 *value64,
> +			    void *handler_context, void *region_context)
> +{
> +	struct intel_soc_pmic_opregion *opregion =3D region_context;
> +	struct regmap *regmap =3D opregion->regmap;
> +	struct intel_soc_pmic_opregion_data *d =3D opregion->data;
> +	struct pmic_pwr_reg *preg;
> +	int result;
> +
> +	if (bits !=3D 32 || !value64)
> +		return AE_BAD_PARAMETER;
> +
> +	if (function =3D=3D ACPI_WRITE && !(*value64 =3D=3D 0 || *value64 =3D=
=3D 1))
> +		return AE_BAD_PARAMETER;
> +
> +	preg =3D pmic_get_pwr_reg(address, d->pwr_table, d->pwr_table_count=
);
> +	if (!preg)
> +		return AE_BAD_PARAMETER;
> +
> +	mutex_lock(&opregion->lock);
> +
> +	if (function =3D=3D ACPI_READ)
> +		result =3D d->get_power(regmap, preg, value64);
> +	else
> +		result =3D d->update_power(regmap, preg, *value64 =3D=3D 1);
> +
> +	mutex_unlock(&opregion->lock);
> +
> +	return result ? AE_ERROR : AE_OK;
> +}
> +
> +static acpi_status pmic_read_temp(struct intel_soc_pmic_opregion *op=
region,
> +				  int reg, u64 *value)
> +{
> +	int raw_temp, temp;
> +
> +	if (!opregion->data->get_raw_temp)
> +		return AE_BAD_PARAMETER;
> +
> +	raw_temp =3D opregion->data->get_raw_temp(opregion->regmap, reg);
> +	if (raw_temp < 0)
> +		return AE_ERROR;
> +
> +	if (!opregion->lpat) {
> +		*value =3D raw_temp;
> +		return AE_OK;
> +	}
> +
> +	temp =3D raw_to_temp(opregion->lpat, opregion->lpat_count, raw_temp=
);
> +	if (temp < 0)
> +		return AE_ERROR;
> +
> +	*value =3D temp;
> +	return AE_OK;
> +}
> +
> +static acpi_status pmic_dptf_temp(struct intel_soc_pmic_opregion *op=
region,
> +				  int reg, u32 function, u64 *value)
> +{
> +	if (function !=3D ACPI_READ)
> +		return AE_BAD_PARAMETER;
> +
> +	return pmic_read_temp(opregion, reg, value);
> +}
> +
> +static acpi_status pmic_dptf_aux(struct intel_soc_pmic_opregion *opr=
egion,
> +				 int reg, u32 function, u64 *value)
> +{
> +	int raw_temp;
> +
> +	if (function =3D=3D ACPI_READ)
> +		return pmic_read_temp(opregion, reg, value);
> +
> +	if (!opregion->data->update_aux)
> +		return AE_BAD_PARAMETER;
> +
> +	if (opregion->lpat) {
> +		raw_temp =3D temp_to_raw(opregion->lpat, opregion->lpat_count,
> +					 *value);
> +		if (raw_temp < 0)
> +			return AE_ERROR;
> +	} else {
> +		raw_temp =3D *value;
> +	}
> +
> +	return opregion->data->update_aux(opregion->regmap, reg, raw_temp) =
?
> +		AE_ERROR : AE_OK;
> +}
> +
> +static acpi_status pmic_dptf_pen(struct intel_soc_pmic_opregion *opr=
egion,
> +				 int reg, u32 function, u64 *value)
> +{
> +	struct intel_soc_pmic_opregion_data *d =3D opregion->data;
> +	struct regmap *regmap =3D opregion->regmap;
> +
> +	if (!d->get_policy || !d->update_policy)
> +		return AE_BAD_PARAMETER;
> +
> +	if (function =3D=3D ACPI_READ)
> +		return d->get_policy(regmap, reg, value) ? AE_ERROR : AE_OK;
> +
> +	if (*value !=3D 0 || *value !=3D 1)
> +		return AE_BAD_PARAMETER;
> +
> +	return d->update_policy(regmap, reg, *value) ? AE_ERROR : AE_OK;
> +}
> +
> +static bool pmic_dptf_is_temp(int address)
> +{
> +	return (address <=3D 0x3c) && !(address % 12);
> +}
> +
> +static bool pmic_dptf_is_aux(int address)
> +{
> +	return (address >=3D 4 && address <=3D 0x40 && !((address - 4) % 12=
)) ||
> +	       (address >=3D 8 && address <=3D 0x44 && !((address - 8) % 12=
));
> +}
> +
> +static bool pmic_dptf_is_pen(int address)
> +{
> +	return address >=3D 0x48 && address <=3D 0x5c;
> +}
> +
> +static acpi_status
> +intel_soc_pmic_dptf_handler(u32 function, acpi_physical_address addr=
ess,
> +			    u32 bits, u64 *value64,
> +			    void *handler_context, void *region_context)
> +{
> +	struct intel_soc_pmic_opregion *opregion =3D region_context;
> +	int reg;
> +	int result;
> +
> +	if (bits !=3D 32 || !value64)
> +		return AE_BAD_PARAMETER;
> +
> +	reg =3D pmic_get_dptf_reg(address, opregion->data->dptf_table,
> +				opregion->data->dptf_table_count);
> +	if (!reg)
> +		return AE_BAD_PARAMETER;
> +
> +	mutex_lock(&opregion->lock);
> +
> +	result =3D AE_BAD_PARAMETER;
> +	if (pmic_dptf_is_temp(address))
> +		result =3D pmic_dptf_temp(opregion, reg, function, value64);
> +	else if (pmic_dptf_is_aux(address))
> +		result =3D pmic_dptf_aux(opregion, reg, function, value64);
> +	else if (pmic_dptf_is_pen(address))
> +		result =3D pmic_dptf_pen(opregion, reg, function, value64);
> +
> +	mutex_unlock(&opregion->lock);
> +
> +	return result;
> +}
> +
> +int
> +intel_soc_pmic_install_opregion_handler(struct device *dev,
> +					acpi_handle handle,
> +					struct regmap *regmap,
> +					struct intel_soc_pmic_opregion_data *d)
> +{
> +	acpi_status status;
> +	struct intel_soc_pmic_opregion *opregion;
> +
> +	if (!dev || !regmap || !d)
> +		return -EINVAL;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	opregion =3D devm_kzalloc(dev, sizeof(*opregion), GFP_KERNEL);
> +	if (!opregion)
> +		return -ENOMEM;
> +
> +	mutex_init(&opregion->lock);
> +	opregion->regmap =3D regmap;
> +	pmic_dptf_lpat(opregion, handle, dev);
> +
> +	status =3D acpi_install_address_space_handler(handle,
> +						    PMIC_PMOP_OPREGION_ID,
> +						    intel_soc_pmic_pmop_handler,
> +						    NULL, opregion);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	status =3D acpi_install_address_space_handler(handle,
> +						    PMIC_DPTF_OPREGION_ID,
> +						    intel_soc_pmic_dptf_handler,
> +						    NULL, opregion);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_remove_address_space_handler(handle, PMIC_PMOP_OPREGION_ID,
> +						  intel_soc_pmic_pmop_handler);
> +		return -ENODEV;
> +	}
> +
> +	opregion->data =3D d;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_soc_pmic_install_opregion_handler);
> +
> +void intel_soc_pmic_remove_opregion_handler(acpi_handle handle)
> +{
> +	acpi_remove_address_space_handler(handle, PMIC_PMOP_OPREGION_ID,
> +					  intel_soc_pmic_pmop_handler);
> +	acpi_remove_address_space_handler(handle, PMIC_DPTF_OPREGION_ID,
> +					  intel_soc_pmic_dptf_handler);
> +}
> +EXPORT_SYMBOL_GPL(intel_soc_pmic_remove_opregion_handler);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/intel_soc_pmic_opregion.h b/drivers/mfd/inte=
l_soc_pmic_opregion.h
> new file mode 100644
> index 000000000000..752ec3d2bcbb
> --- /dev/null
> +++ b/drivers/mfd/intel_soc_pmic_opregion.h
> @@ -0,0 +1,35 @@
> +#ifndef __INTEL_SOC_PMIC_OPREGION_H
> +#define __INTEL_SOC_PMIC_OPREGION_H
> +
> +struct pmic_pwr_reg {
> +	int reg;	/* corresponding PMIC register */
> +	int bit;	/* control bit for power */
> +};
> +
> +struct pmic_pwr_table {
> +	int address;	/* operation region address */
> +	struct pmic_pwr_reg pwr_reg;
> +};
> +
> +struct pmic_dptf_table {
> +	int address;	/* operation region address */
> +	int reg;	/* corresponding thermal register */
> +};
> +
> +struct intel_soc_pmic_opregion_data {
> +	int (*get_power)(struct regmap *r, struct pmic_pwr_reg *preg, u64 *=
value);
> +	int (*update_power)(struct regmap *r, struct pmic_pwr_reg *preg, bo=
ol on);
> +	int (*get_raw_temp)(struct regmap *r, int reg);
> +	int (*update_aux)(struct regmap *r, int reg, int raw_temp);
> +	int (*get_policy)(struct regmap *r, int reg, u64 *value);
> +	int (*update_policy)(struct regmap *r, int reg, int enable);
> +	struct pmic_pwr_table *pwr_table;
> +	int pwr_table_count;
> +	struct pmic_dptf_table *dptf_table;
> +	int dptf_table_count;
> +};
> +
> +int intel_soc_pmic_install_opregion_handler(struct device *dev, acpi=
_handle handle, struct regmap *regmap, struct intel_soc_pmic_opregion_d=
ata *d);
> +void intel_soc_pmic_remove_opregion_handler(acpi_handle handle);
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
